#!/bin/bash
export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo ${TRAVIS_BRANCH:1} ; fi`

function dockerPublish {
    cd ../$1/
    docker build -f Dockerfile --squash -t $2:$TAG .
    docker push $2
    cd -
}

echo "========> START PUBLISHING $2"
docker login -u $DOCKER_USER -p $DOCKER_PASS
echo "========> BUILD & PUBLISH $1 Containers (public)"
dockerPublish $1 $2
echo "========> END PUBLISHING $2"
exit 0;