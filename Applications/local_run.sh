#!/bin/bash
docker run -d -p 85:80 --name="lbpma" app-pma
docker run -d -p 87:80 --name="lbrockmongo" app-rockmongo