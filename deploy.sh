#!/bin/bash

ENVIRONMENT=$1
CONFIG_FILE="functions-config.json"

NO_VERIFY_FUNCTIONS=$(jq -r ".$ENVIRONMENT.noVerifyJwt[]" $CONFIG_FILE)
VERIFY_FUNCTIONS=$(jq -r ".$ENVIRONMENT.verifyJwt[]" $CONFIG_FILE)

for function in $NO_VERIFY_FUNCTIONS; do
  echo "Deploying $function cwith --no-verify-jwt"
  supabase functions deploy $function --no-verify-jwt
done

for function in $VERIFY_FUNCTIONS; do
  echo "Deploying $function with JWT verification"
  supabase functions deploy $function
done
