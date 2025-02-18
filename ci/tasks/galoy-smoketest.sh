#!/bin/bash

source smoketest-settings/helpers.sh

host=`setting "galoy_endpoint"`

curl --location --request POST "${host}:4000/graphql"\
 --header 'Content-Type: application/json' \
 --data-raw '{"query":"query prices {\n    prices(length: 0) {\n        id\n        o\n    }\n}","variables":{}}' > response.json

if [[ $(cat ./response.json | jq -r '.errors') != "null" ]]; then
  echo Testflight failed! - Response:
  cat response.json
  echo Contains "errors" key
  exit 1
fi
