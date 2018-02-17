#!/bin/bash


function dockerBuild {
    sudo docker-compose -f docker-compose-$1.yml build $2
}

function dockerRun {
    sudo docker-compose -f docker-compose-$1.yml up $2
}

function dockerPs {
    sudo docker-compose -f docker-compose-$1.yml ps $2
}


echo "========> START TEST"
echo "========> BUILDING OS Containers (test)"
dockerBuild os fedora
echo "========> BUILDING Services Containers (test)"
dockerBuild sv
echo "========> BUILDING Applications Containers (test)"
dockerBuild app
echo "========> START OS Containers (test)"
dockerRun os fedora
echo "========> START Services Containers (test)"
dockerRun sv
echo "========> START Applications Containers (test)"
dockerRun app
echo "========> STATUS OS Containers (test)"
dockerPs os fedora
echo "========> STATUS Services Containers (test)"
dockerPs sv
echo "========> STATUS Applications Containers (test)"
dockerPs app
echo "========> END TEST"
exit 0;