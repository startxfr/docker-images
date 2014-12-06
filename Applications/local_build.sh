#!/bin/bash
docker build -t app-pma:fc21 Applications/phpmyadmin/
docker build -t app-rockmongo:fc21 Applications/rockmongo/