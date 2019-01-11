#!/bin/bash

set -euo pipefail

readonly DOCKER_PASSWORD=${DOCKER_PASSWORD:-}

if [[ -z "$DOCKER_PASSWORD" ]]; then
    echo 'DOCKER_PASSWORD is not available, aborting.'
    exit 1
fi

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker tag kybernetwork/ropsten-faucet:"$TRAVIS_COMMIT" kybernetwork/ropsten-faucet:"$TRAVIS_BRANCH"
docker tag kybernetwork/ropsten-faucet-site:"$TRAVIS_COMMIT" kybernetwork/ropsten-faucet-site:"$TRAVIS_BRANCH"
if [[ -n "$TRAVIS_TAG" ]]; then
    docker tag kybernetwork/ropsten-faucet:"$TRAVIS_COMMIT" kybernetwork/ropsten-faucet:"$TRAVIS_TAG"
    docker tag kybernetwork/ropsten-faucet-site:"$TRAVIS_COMMIT" kybernetwork/ropsten-faucet-site:"$TRAVIS_TAG"
fi

docker push kybernetwork/ropsten-faucet
docker push kybernetwork/ropsten-faucet-site
