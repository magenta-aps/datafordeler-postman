STS-Tests
=========

As Postman does not support testing with different client authtication
certificates, shell scripts have been developed to execute this part of the
testing-suite.

# Usage

To run the test-suite acquire four client authenticifcation certificates for
the STS via DafoAdmin, namely:

* Single-User certificate for CPR
* Single-User certificate for CVR
* Multi-User certificate for CPR
* Multi-User certificate for CVR

We expect a fully POSIX complient environment to be present, includes `openssl`
and `curl`.

Aditionally, the saml-library must be setup, see [../saml-library/README.md](../saml-library/README.md).

## Running the tests

We assume the certificates are; su-cpr.p12, su-cvr.p12, mu-cpr.p12 and 
mu-cvr.p12 (respectively).

The test-suite can now be executed one at a time, by running:

    ./token_single_user_cert.sh su-cpr.p12 "Adgang til CPR"
    ./token_single_user_cert.sh su-cvr.p12 "Adgang til CVR"

    ./token_multi_user_cert.sh mu-cpr.p12 "Adgang til CPR"
    ./token_multi_user_cert.sh mu-cvr.p12 "Adgang til CVR"

Each test-run is somewhat verbose, but ends with either: `Failure.` or `All OK`.
