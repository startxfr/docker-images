STARTX docker-images - OOConv
=============================

**Description**  
Based on the docker default centos Dockerfile

**Usage**  

	  docker run --name="test-ooconv" startx/sv-ooconv unoconv
	  docker run -d -p 2002:2002 --name="test-ooconv" startx/sv-ooconv


**Converting documents**

	// Start the server 
	unoconv --listener --server 1.2.3.4 --port 2002

	// Use the client to connect to the convertion server
	unoconv --server 1.2.3.4 --port 2002
