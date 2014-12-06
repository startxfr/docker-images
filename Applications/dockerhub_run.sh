#!/bin/bash
docker run -d -p 84:80 --name="fc21-pma" startx/app-pma:fc21
docker run -d -p 86:80 --name="fc21-rockmongo" startx/app-rockmongo:fc21