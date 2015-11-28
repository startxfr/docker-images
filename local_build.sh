#!/bin/bash
cd OS; docker-compose build; cd -;
Services/local_build.sh
Applications/local_build.sh