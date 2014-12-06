#!/bin/bash
docker build -t app-pma Applications/phpmyadmin/
docker build -t app-rockmongo Applications/rockmongo/