#!/bin/sh

set -x

curl -n -X PATCH https://api.heroku.com/apps/$HEROKU_APP/config-vars -d @scripts/${CI_ENVIRONMENT_NAME}.config.json -H "Content-Type: application/json"  -H "Accept: application/vnd.heroku+json; version=3" --header "Authorization: Bearer ${HEROKU_TOKEN}"

# Esta feo, pero no pude encontrar la forma de meterlo en el archivo .config.json
curl -n -X PATCH https://api.heroku.com/apps/$HEROKU_APP/config-vars -d '{"TOKEN_API_CLIMA":"'"${TOKEN_API_CLIMA}"'"}' -H "Content-Type: application/json"  -H "Accept: application/vnd.heroku+json; version=3" --header "Authorization: Bearer ${HEROKU_TOKEN}"
