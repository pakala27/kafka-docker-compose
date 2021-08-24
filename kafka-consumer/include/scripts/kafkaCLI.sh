#!/bin/bash

set -u -e

INPUT_TOPIC=${INPUT_TOPIC}
OUTPUT_TOPIC=${OUTPUT_TOPIC}
FILE_ORIG=${FILE_ORIG}
FILE_SORTED=${FILE_SORTED}
BOOTSTRAP_SERVERS=${BOOTSTRAP_SERVERS}
CONSUMER_GROUP=${CONSUMER_GROUP}
TIMEOUT_MS=${TIMEOUT_MS}

function env_check() {
  echo "Checking ENV variables"
  if [[ "${INPUT_TOPIC}" == "" || "${OUTPUT_TOPIC}" == "" ]]; then
    echo "Please provide input and output topcs"
    exit 1
  fi
}

function consumer() {
  echo "Consume messages from input topic ${INPUT_TOPIC}" 
  kafka-console-consumer \
    --bootstrap-server ${BOOTSTRAP_SERVERS} \
    --topic ${INPUT_TOPIC} \
    --timeout-ms ${TIMEOUT_MS} \
    --from-beginning \
    --group ${CONSUMER_GROUP} > ${FILE_ORIG}
}

function producer() {
  echo "Produce messages to putput topic"
  kafka-console-producer \
    --bootstrap-server ${BOOTSTRAP_SERVERS} \
    --topic ${OUTPUT_TOPIC} < ${FILE_SORTED}
} 

function sorting() {
  echo "sorting messages using python script"
  python /scripts/sortMessages.py
} 

function cleanup() {
  echo "Delete files file ${FILE_ORIG} and ${FILE_SORTED}"
  rm ${FILE_ORIG} ${FILE_SORTED}
} 


env_check
consumer
sorting
producer

