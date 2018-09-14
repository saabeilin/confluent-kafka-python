#!/usr/bin/env bash
set -eu

cleanup() {
        ${DOCKER_BIN}/cluster_down.sh
}

trap cleanup 0 2 3 6 15

TEST_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source ${TEST_SOURCE}/../../docker/.env

if [[ ${1:-} == "help" ]]; then
    python ${TEST_SOURCE}/integration_test.py --help
    exit 1
fi

#start cluster
${DOCKER_BIN}/cluster_up.sh

if [[ $? -ne 0 ]]; then
    exit 1
fi

run_tox() {
    echo "Executing tox $@"
    cd ${TEST_SOURCE}/..
    tox -r "$@"
}

run_native() {
    for mode in "$@"; do
        modes="${modes:-} --${mode}"
    done
    echo "Executing test modes $@"
    python ${TEST_SOURCE}/integration_test.py ${modes:-} ${TEST_SOURCE}/testconf.json
}

if [[ ${1:-} == "tox" ]]; then
  shift
  run_tox $@
else
  run_native $@
fi
