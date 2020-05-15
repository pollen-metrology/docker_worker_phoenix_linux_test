#!/bin/bash

term_handler() {
      echo "Unregister Runner..."
      gitlab-runner unregister --all-runners
    }

start() {
  echo "Register runner..."

  gitlab-runner register \
    --non-interactive \
    --executor "shell" \
    --docker-image alpine:latest \
    --url "https://gitlab.com/" \
    --registration-token "nYAsaK9DqxZevC5Sn5Qn" \
    --description "Kubernetes-Runner" \
    --tag-list "phoenix-test,pyphoenix-test" \
    --run-untagged="true" \
    --locked="false" &&

  echo "Run the runner... "  

  gitlab-runner run &

# Keep Alive
  while true
    do
      tail -f /dev/null & wait ${!}
    done
  
  }


trap 'kill ${!}; term_handler' SIGTERM

start ${!}
#tail -f /dev/null

#Extra line added in the script to run all command line arguments
#exec "$@";
#while true
#    do
#      tail -f /dev/null & wait ${!}
#    done