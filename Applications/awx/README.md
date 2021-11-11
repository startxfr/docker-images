[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://gitlab.com/startx1/containers)

# STARTX Application docker-images : AWX

Container running Ansible AWX infrastructure with backend components. 
Only based on public image. Do not need to be builded before running it

## Run from local docker with docker-compose

### Copy sources in your docker host 

```bash
mkdir startx-docker-images; 
cd startx-docker-images;
git clone https://gitlab.com/startx1/containers.git .
```

### Run local containers

```bash
cd Applications/awx
docker-compose up -d
```

### Monitor deployment

Wait for backend database initialisation (could take minutes)

```bash
cd Applications/awx
docker-compose logs awx_task
```

### Accessing console

access the web console

```bash
firefox http://localhost:9220
```

## Run from openshift PaaS

### Connect to your openshift cluster

```bash
oc login -u <user> -p <pass> <url>
```

### Create a project in order to scope the application

```bash
oc new-project demo
```

### Add template to the project catalog

```bash
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Applications/awx/openshift-template.yml
```

### Execute this template

```bash
oc create -t startx-app-awx-template
```

### Observe deployement

```bash
oc get all
oc logs dc/awx-awx_task
```

## Related Resources
* [Sources files](https://gitlab.com/startx1/containers/tree/master/Applications/awx)
* [Github STARTX profile](https://gitlab.com/startx1/containers)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/app-awx/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)