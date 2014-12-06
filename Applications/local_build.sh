#!/bin/bash
docker build -t app-pma:fc20 Applications/phpmyadmin/
docker build -t app-rockmongo:fc20 Applications/rockmongo/