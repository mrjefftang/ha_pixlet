#!/usr/bin/with-contenv bashio
TOKEN=${SUPERVISOR_TOKEN}
ENTITY_ID=$(bashio::config 'entity_id')

PIXLET_DATA=$(bashio::config 'pixlet_data')
PIXLET_FILE="/data/pixlet.star"


echo "${PIXLET_DATA}" > ${PIXLET_FILE}

sed -i "s/HA_SUPERVISOR_TOKEN/${TOKEN}/" ${PIXLET_FILE}
sed -i "s/HA_ENTITY_ID/${ENTITY_ID}/" ${PIXLET_FILE}

pixlet -i 0.0.0.0 -p 8000 serve ${PIXLET_FILE}