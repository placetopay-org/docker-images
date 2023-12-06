#!/usr/bin/env bash

source "$(dirname "$0")/common.sh"

set -e

enable_debug() {
  if [[ "${DEBUG}" == "true" ]]; then
    info "Enabling debug mode."
    set -x
  fi
}
enable_debug


run_pipe() {
    if [[ ${CHECK_BACKEND} = "ON" ]]; then
        info "Executing Check Backend"
        check_coding_back.sh
    fi

    if [[ ${CHECK_FRONTEND} = "ON" ]]; then
        info "Executing Check Frontend"
        check_coding_front.sh
    fi

    if [[ "${?}" == "0" ]]; then
        success "Execution finished."
    else
        fail "Execution failed."
    fi
}

run_pipe