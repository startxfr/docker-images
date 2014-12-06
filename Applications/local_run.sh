#!/bin/bash
docker run -d -p 95:80 --name="fc20-lbpma" app-pma:fc20
docker run -d -p 97:80 --name="fc20-lbrockmongo" app-rockmongo:fc20