#!/bin/bash
docker run -d -p 105:80 --name="fc21-lbpma" app-pma:fc21
docker run -d -p 107:80 --name="fc21-lbrockmongo" app-rockmongo:fc21