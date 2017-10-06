Postman Test-suite
==================

Tests the Datafordeler Secure Token Service, and Datafordeler Services using
[Postman](https://www.getpostman.com/).

# Note
Due to limitations in Postman, some tests are handled seperately, namely the 
client authentification certificate tests for the STS. For more information 
about how these and handled, and how to run these tests, please refer to 
[STS-tests/README.md](STS-tests/README.md).

Additionally the test of SAML IdP has not been automated, as it is not easily
unit-tested, but rather require a full-scale integration test. It has however
been manually tested thoroughly, as it is used in-house.

# Usage
To run the test-suite, first Postman must be installed using the above link.

Once Postman has been installed, the test-suite can be imported using the
'Import dialogbox' (Ctrl+O), picking 'Import Folder' and importing the folder
containing this `README.md` file.

At this point the DAFO collection should show up, and all tests should be
loaded. The only thing left to do, is picking the 'Datafordeler' environment in
the top-right, and adjusting it, with the passwords for the cpr and cvr users.

## Running the tests
The tests can be run the Postman 'Collection Runner', for details, see the
[Postman documentation](https://www.getpostman.com/docs/postman/collection_runs/starting_a_collection_run).

# Technical details

## Libraries:

To validate SAML tokens a library is included, however as Postman
[does not support loading libraries directly](https://github.com/postmanlabs/postman-app-support/issues/1180),
loading is done using `eval`, from a global variable (see `saml_decode` in
[`globals.postman_globals.json`](globals.postman_globals.json)).

The library is included in the `saml-library` subfolder.

## Execution order:

As postman executes tests in lexicographical order, we have prefixed tests with
a section number, to ensure tests are run as we please. This was suggested 
[here](https://stackoverflow.com/questions/43336057/).
