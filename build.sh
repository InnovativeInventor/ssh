#!/bin/bash
echo "Running . . ."

# Pulling from docker
docker pull innovativeinventor/ssh

# Getting random.sh file
mkdir -p assets
curl -L https://bit.ly/2uGNBbW -o assets/random.sh

# Checking ports
BASE=522
INCREMENT=1
port=$BASE
isfree=$(lsof -i -n -P | grep $port)

# Adding one every time a port is used up
while [[ -n "$isfree" ]]; do
  port=$[port+INCREMENT]
  isfree=$(lsof -i -n -P | grep $port)
done

# Getting password for container
echo Password:
read -s password

# Checking if name exists

# Adding docker is free varible and docker is exited varible
dockerisfree=$(docker ps -q -f name=ssh$num)
dockerisexited=$(docker ps -aq -f status=exited -f name=ssh)

# If statements
if [[ -n "$dockerisfree" ]]; then

	# Checking if it is exited
    if [[ -n "$dockerisexited" ]]; then

    	# Asking user if it is okay to delete exited container with the same name
    	echo "A exited version of docker-ssh has been detected, do you want to delete it?"
    	read -r -p "Are you sure? [y/N] " response
		if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
		then

			# Creating everything, then exiting to prevent errors
    		docker rm ssh
    		docker run --name=ssh -d -p $port:22 innovativeinventor/ssh
			sudo assets/random.sh -d ssh
			printf "$password\n$password\n"  | docker exec -i ssh$num passwd root
			echo "Done! A container with the name ssh and the ssh port $port has been created for you. Entropy has been added to the system from this server, and the ssh keys have been regenerated."
			exit 10

    	elif [[ "$response" =~ ^([nN][oO]|[nN])+$ ]]
    	then
    		# Allowing to proceed
    		echo "Okay, creating a new container with different name"

		else
    		echo "Error, invalid input"
		fi
    fi

    # Figuring out what number suffix to attach to the end
	DOCKERBASE=1
	DOCKERINCREMENT=1

	num=$DOCKERBASE

	while [[ -n "$dockerisfree" ]];do
		num=$[num+DOCKERINCREMENT]
		dockerisfree=$(docker ps -q -f name=ssh$num)
	done
	echo $num

	# Creating everything, then exiting to prevent errors
    docker run --name=ssh$num -d -p $port:22 innovativeinventor/ssh
	sudo assets/random.sh -d ssh$num 
	printf "$password\n$password\n"  | docker exec -i ssh$num passwd root
	exit 10
fi

# Mainly for debugging purposes
echo "Setting up new version using name of $ssh$num"

# Installing
docker run --name=ssh -d -p $port:22 innovativeinventor/ssh
sudo assets/random.sh -d ssh 
printf "$password\n$password\n"  | docker exec -i ssh$num passwd root