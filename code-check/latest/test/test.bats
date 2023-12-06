#!/usr/bin/env bats

setup() {
  DOCKER_IMAGE=${DOCKER_IMAGE:="placetopay/code-check"}

  echo "Building image..."
  docker build -t ${DOCKER_IMAGE}:test .
}

@test "Dummy test" {
    run docker run \
        -e DEBUG="true" \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        placetopay/code-check 

    echo "Status: $status"
    echo "Output: $output"

    [ "$status" -eq 0 ]
}
