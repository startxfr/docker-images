#!/bin/bash
docker run -d -p 104:80 --name="fc21-pma" startx/app-pma:fc21
docker run -d -p 106:80 --name="fc21-rockmongo" startx/app-rockmongo:fc21