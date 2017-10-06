#!/bin/bash
set -e

DIR=$(dirname "$0")

if [ $# -ne 2 ]; then
    echo "Please provide the path to a p12 certificate as an argument."
    echo "Please provide an expected XML string as an argument."
    exit 1
fi

P12_CERT=$1
EXPECTED_STRING=$2

if [ ! -f $P12_CERT ]; then
    echo "THe provided path is invalid."
    exit 1
fi

TEMP_FOLDER=$(mktemp -d)

function cleanup {
    rm -rf $TEMP_FOLDER
}
trap cleanup EXIT

function error {
    echo ""
    echo "Failure."
}
trap error ERR

echo "Converting certificate"
echo "----------------------"
PEM_KEY=$TEMP_FOLDER/key.pem 
openssl pkcs12 -in $P12_CERT -out $PEM_KEY -nocerts -nodes -password pass:

PEM_CRT=$TEMP_FOLDER/crt.pem 
openssl pkcs12 -in $P12_CERT -out $PEM_CRT -clcerts -nokeys -password pass:

CWD=$PWD

echo ""
echo "Acquiring SAML token via STS"
echo "----------------------------"
STS_URL=https://sts-cert.test.data.gl/get_token
SAML_TOKEN=$(curl --silent -m 15 --cert $PEM_CRT --key $PEM_KEY $STS_URL)
echo $SAML_TOKEN

echo ""
echo "Decoding SAML token"
echo "-------------------"
cd $DIR
cd ..
cd saml-library
SAML_XML=$(node saml_standalone.js "$SAML_TOKEN")
cd ..
cd $DIR
echo "$SAML_XML"

echo ""
echo "Checking SAML token"
echo "-------------------"
echo "$SAML_XML" | grep "$EXPECTED_STRING" >/dev/null
echo "$SAML_XML" | grep "<saml2:Audience>https://data.gl/</saml2:Audience>" >/dev/null
echo "$SAML_XML" | grep ">Dafo-STS</saml2:Issuer>" >/dev/null
cd $CWD

echo "All OK"
