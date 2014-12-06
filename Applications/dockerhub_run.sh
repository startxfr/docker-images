#!/bin/bash
docker run -d -p 84:80 --name="pma" startx/app-pma
docker run -d -p 86:80 --name="rockmongo" startx/app-rockmongo