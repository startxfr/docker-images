#!/bin/bash
docker run -d -p 85:80 --name="fc21-lbpma" app-pma:fc21
docker run -d -p 87:80 --name="fc21-lbrockmongo" app-rockmongo:fc21