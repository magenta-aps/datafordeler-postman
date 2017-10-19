#!/bin/bash

function write_test()
{
    NAME=$1
    CERT=$2
    STATUS=$3
    MULTI=$4

    echo "↳ $NAME"
    if [ $MULTI -eq 0 ]; then
        echo "  GET https://sts-cert.test.data.gl/get_token"
    else
        echo "  GET https://sts-cert.test.data.gl/get_token?on_behalf_of=testbruger"
    fi

    echo "  Certificate '$2'"
    if [ $STATUS -eq 0 ]; then
        echo "  ✓  All OK"
    else
        echo "  x  Failed"
    fi
    echo ""
}

echo "fakeman"
echo ""
echo "STS"
echo ""

echo "❏ Single user certifiate"

./token_single_user_cert.sh su-cpr.p12 "Adgang til CPR" 2>&1 \
    | grep "All OK" >/dev/null
STATUS=$?
write_test "Acquire STS tokens / CPR" su-cpr.p12 $STATUS 0

./token_single_user_cert.sh su-cvr.p12 "Adgang til CVR" 2>&1 \
    | grep "All OK" >/dev/null

STATUS=$?
write_test "Acquire STS tokens / CVR" su-cvr.p12 $STATUS 0

echo "❏ Multi user certifiate"
./token_multi_user_cert.sh mu-cpr.p12 "Adgang til CPR" 2>&1 \
    | grep "All OK" >/dev/null
STATUS=$?
write_test "Acquire STS tokens / CPR" mu-cpr.p12 $STATUS 1

./token_multi_user_cert.sh mu-cvr.p12 "Adgang til CVR" 2>&1 \
    | grep "All OK" 2>&1 >/dev/null
STATUS=$?
write_test "Acquire STS tokens / CPR" mu-cvr.p12 $STATUS 1
