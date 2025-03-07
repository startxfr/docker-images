#!/bin/bash
IMGLIST="latest fc37 fc36 fc35 fc34 fc33 fc32 fc31 fc30 fc29 fc28 fc27 fc26 fc23 fc22 alpine3 alma8 rocky8 centos8 centos7 centos6 ubi8"
IMGLISTFC="latest 35 34 33 32 31 30 29 28 27 26 23 22"
IMGLISTCENTOS="latest 8 7 6"
IMGLISTALPINE="latest 3"
IMGLISTUBI="latest 8"

# # test OS
# echo "OS =============================================";
# REPO="fedora"
# CMDTEST="bash --version"
# for i in $IMGLISTFC; do 
# 	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
# done
# REPO="centos"
# CMDTEST="bash --version"
# for i in $IMGLISTCENTOS; do 
# 	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
# done
# REPO="alpine"
# CMDTEST="bash --version"
# for i in $IMGLISTALPINE; do 
# 	docker rm -vf $REPO-$i &> /dev/null; 
# 	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
# done
# REPO="ubi"
# CMDTEST="bash --version"
# for i in $IMGLISTUBI; do 
# 	docker rm -vf $REPO-$i &> /dev/null; 
# 	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
# done

# # test apache
# REPO="sv-apache"
# CMDTEST="httpd -v"
# echo "$REPO =============================================";
# for i in $IMGLIST; do 
# 	docker rm -vf $REPO-$i &> /dev/null; 
# 	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
# done

# test couchbase
REPO="sv-couchbase"
CMDTEST="couchbase-server -v"
echo "$REPO =============================================";
for i in $IMGLIST; do 
	docker rm -vf $REPO-$i &> /dev/null; 
	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
done

# # test mariadb
# REPO="sv-mariadb"
# CMDTEST=" mysql --version"
# echo "$REPO =============================================";
# for i in $IMGLIST; do 
# 	docker rm -vf $REPO-$i &> /dev/null; 
# 	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
# done

# # test memcache
# REPO="sv-memcache"
# CMDTEST="memcache --version"
# echo "$REPO =============================================";
# for i in $IMGLIST; do 
# 	docker rm -vf $REPO-$i &> /dev/null; 
# 	docker run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $(docker logs $REPO-$i | head -n 1)";
# done