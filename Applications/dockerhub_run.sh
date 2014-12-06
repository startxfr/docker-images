#!/bin/bash
docker run -d -p 94:80 --name="fc20-pma" startx/app-pma:fc20
docker run -d -p 96:80 --name="fc20-rockmongo" startx/app-rockmongo:fc20