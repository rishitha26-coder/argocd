#!/bin/bash

shopt -s extglob

TEMPLATE_FILE="$1"
ENVIRONMENT="$2"
APP="$3"
REVISION="$4"
OUTPUT_DIRECTORY=apps-${ENVIRONMENT}/templates

if [[ ! -d "$OUTPUT_DIRECTORY" ]] || [[ ! -s "$TEMPLATE_FILE" ]] || [[ "$ENVIRONMENT" != @(dev|qa|staging|training|demo|prod) ]] || [[ ! -n "$APP" ]] || [[ ! -n "$REVISION" ]] ; then
	echo "Usage: ${0} <TEMPLATE> <ENVIRONMENT> <APP_NAME> <REVISION> [ <NAMESPACE> ]"
	exit 1
fi

NAMESPACE="${5:-mogo-${ENVIRONMENT}}"

shopt -s extglob

SHORT_NAME=${APP//-/}
SHORT_NAME=${SHORT_NAME//service/srv}
echo short name $SHORT_NAME
sed -e "s/{{ .Values.apps.name }}/${APP}/g" \
       -e "s/@@SHORT_NAME@@/${SHORT_NAME}/g" \
       -e "s/@@NAMESPACE@@/${NAMESPACE}/g" \
       -e "s/@@REVISION@@/${REVISION}/g" \
       "$TEMPLATE_FILE" > ${OUTPUT_DIRECTORY}/${APP}.yaml
