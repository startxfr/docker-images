STARTX docker-images - RockMongo
================================

**Description**  
Based on the [maxexcloo rockmongo](https://github.com/maxexcloo/Docker) Dockerfile

**Usage**  

          docker run --name="app-rm" -p 81:80 -d -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/pma
          docker run --name="app-rm" -d --link mongodb:mongodb -e VIRTUAL_HOST=rm.project.dev.startx.fr startx/app-rockmongo
