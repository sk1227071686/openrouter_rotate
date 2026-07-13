#!/bin/bash

INTERVAL=5

mapfile -t API_KEYS < .env 

function rotate_once()
{

	for key in "${API_KEYS[@]}"
	do
		jq ".env.ANTHROPIC_AUTH_TOKEN = \"$key\"" template_settings.json > /tmp/template_settings.json && mv /tmp/template_settings.json ~/.claude/settings.json
		sleep $INTERVAL
	done	
}


while true
do
	rotate_once
done

