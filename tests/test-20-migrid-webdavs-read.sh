#!/bin/bash

source default

${DOCKER:?} run --rm --network host curlimages/curl:8.2.1 \
  --connect-timeout 1 \
  --retry 1 \
  --user "${MIG_TEST_USER}:${MIG_TEST_USER_PASSWORD}" \
  https://${WEBDAVS_DOMAIN}:${DAVS_PORT}/welcome.txt \
  -k \
  -s \
  -v \
  -o /dev/null \
  --fail \
  -sw '%{http_code}\n' \
  > $(basename "$0").log \
  2>&1

[[ "$?" == 0 ]] && echo -e "${GREEN}passed${ENDCOLOR}" && exit 0
echo -e "${RED}failed${ENDCOLOR}" && exit 1
