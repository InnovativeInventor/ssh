# ssh-container
A simple ssh container for docker

# Install
Type in:
 `docker pull innovativeinventor/ssh`

`docker run --name=ssh -d -p 524:22 innovativeinventor/ssh`

To set up a password, type

`docker exec -it ssh passwd`

You will be able to ssh into your container on port 522.
