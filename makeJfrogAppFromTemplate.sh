#!/bin/bash

[[ -s "$1" ]] || exit 1
[[ -d "$2" ]] || exit 1

TEMPLATE_FILE="$1"
OUTPUT_DIRECTORY="$2"

shopt -s extglob

apps=(affiliate-service
api-worker
auto-emt
bank-service
brokerage-layer
card-cashback-service
card-service
communication-service
constellation-service
content-centre-service
content-slide-app-download-service
content-slide-crypto-activation-offer-service
content-slide-crypto-fund-offer-service
content-slide-level-up-service
content-slide-mogo-spend-service
content-slide-offer-expired-service
content-slide-pre-approval-service
content-slide-protect-active-service
content-slide-protect-offer-service
content-slide-referral-partner-service
content-slide-referral-service
content-slide-spend-bitcoin-cashback-service
content-slide-static-service
cronjobs
crypto-exchange-service
crypto-service
equifax-service
file-management-service
fis-service
fraud-service
fs-soa-service
goeasy-service
http-service
id-protect-service
ingress-svc-defs
loan-service
marketing-web
member-service
mogo-soa-api
mortgage-service
netbanx-service
opbot
operations-service
plaid-service
pungle-service
push-notification-service
scheduler-service
scheduler-service-sk-web
segment-service
shared-configmaps
tdc-bridge-service
telesign-service
trigger
trust-science-service
tz-service
ui
ui-sidecar
validation-service
wallet-service
)

for app in ${3:-${apps[@]}} ; do
        SHORT_NAME=${app//-/}
        SHORT_NAME=${SHORT_NAME//service/srv}
	echo short name $SHORT_NAME
	sed -e "s/{{ .Values.apps.name }}/${app}/g" \
                -e "s/@@SHORT_NAME@@/${SHORT_NAME}/g" \
                "$TEMPLATE_FILE" > ${OUTPUT_DIRECTORY}/${app}.yaml
done
