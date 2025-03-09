#!/bin/bash
IMGLIST="latest fc41 fc40 fc39 fc38 fc37 fc36 fc35 fc34 fc33 fc32 fc31 fc30 fc29 fc28 fc27 fc26 fc23 fc22 alpine3 alma8 rocky8 centos9 centos8 centos7 centos6 ubi8"
# shellcheck disable=SC2034
IMGLISTFC="latest 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 23 22"
# shellcheck disable=SC2034
IMGLISTCENTOS="latest 8 7 6"
# shellcheck disable=SC2034
IMGLISTALPINE="latest 3"
# shellcheck disable=SC2034
IMGLISTUBI="latest 8"
SXDI_ENGINE=${SXDI_ENGINE:-podman}

# # test OS
# echo "OS =============================================";
# REPO="fedora"
# CMDTEST="bash --version"
# for i in $IMGLISTFC; do 
# 	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
# done
# REPO="centos"
# CMDTEST="bash --version"
# for i in $IMGLISTCENTOS; do 
# 	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
# done
# REPO="alpine"
# CMDTEST="bash --version"
# for i in $IMGLISTALPINE; do 
# 	$SXDI_ENGINE rm -vf $REPO-$i &> /dev/null; 
# 	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
# done
# REPO="ubi"
# CMDTEST="bash --version"
# for i in $IMGLISTUBI; do 
# 	$SXDI_ENGINE rm -vf $REPO-$i &> /dev/null; 
# 	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
# done

# # test apache
# REPO="sv-apache"
# CMDTEST="httpd -v"
# echo "$REPO =============================================";
# for i in $IMGLIST; do 
# 	$SXDI_ENGINE rm -vf $REPO-$i &> /dev/null; 
# 	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
# done

# test couchbase
REPO="sv-couchbase"
CMDTEST="couchbase-server -v"
echo "$REPO =============================================";
for i in $IMGLIST; do 
	$SXDI_ENGINE rm -vf $REPO-$i &> /dev/null; 
	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
done

# # test mariadb
# REPO="sv-mariadb"
# CMDTEST=" mysql --version"
# echo "$REPO =============================================";
# for i in $IMGLIST; do 
# 	$SXDI_ENGINE rm -vf $REPO-$i &> /dev/null; 
# 	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
# done

# # test memcache
# REPO="sv-memcache"
# CMDTEST="memcache --version"
# echo "$REPO =============================================";
# for i in $IMGLIST; do 
# 	$SXDI_ENGINE rm -vf $REPO-$i &> /dev/null; 
# 	$SXDI_ENGINE run -d --name $REPO-$i startx/$REPO:$i $CMDTEST &> /dev/null; 
# 	echo "$REPO:$i ====> $($SXDI_ENGINE logs $REPO-$i | head -n 1)";
# done