# Ssh-Container
A secure ssh docker container that is simple to set up.


# Background
Most docker ssh containers are insecure. They are started with almost no user interaction, making the ssh keys completely insecure. This docker container uses random data already generated on the docker host and gives some of it to the container to ensure security.

# Install
Type in:


You will be able to ssh into your container on port 522 using the password you just set up.

# Random Data for Docker
If you want the script for adding random data to Docker, check it out at: 