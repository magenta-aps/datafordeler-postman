#!/bin/bash

# newman can be acquired using `npm install -g newman`

newman run DAFO.postman_collection.json \
    -e Datafordeler.postman_environment.json \
    -g globals.postman_globals.json \
    | sed "s/password=.* \[/password=REDACTED \[/g" \
    | sed 's/[[:blank:]]*$//' > report.out
