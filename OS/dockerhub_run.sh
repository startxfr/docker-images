#!/bin/bash
docker run -d --name="fedora" startx/fedora /bin/bash
docker run -d --name="centos" startx/centos /bin/bash