#!/bin/bash

########################
# App Name : Dockerize #
########################

#Define the minimum no. of arguments
APP=`basename $0`

# Function to get the version of the script
# Make sure there is a file called VERSION with the
# version information about the script
get_version () {
    echo -e "\033[34mv1.0\033[0m"
}

# Put your command-line help here
usage () {
    get_version
    echo -e "\n\033[34m$APP : Install Docker (currently supporting Ubuntu only)"
    echo -e "\033[34mUsage :"
    echo -e "\t\033[34m$APP [-h|--help] [-v|--version] [-r|--required 123] [-o|--optional [124]]\033[0m"
    echo -e "\033[34mwhere,"
    echo -e "\t\033[34m-v, --version : Show script version info"
    echo -e "\t\033[34m-h, --help : Show this Help message\033[0m"
}


OPTIONS=`getopt -o vh --long version,help,optional:: -n '$APP' -- "$@"`
if [ $? != 0 ];
then
    echo -e "\033[31mError Parsing arguments\033[0m"
    usage
    exit 1
fi

#echo $OPTIONS
#eval set -- "$OPTIONS"

#Set Variable defaults for the options to be parsed
HELP=false
VERSION=false

while true; do
    case "$1" in
        -v | --version)
            VERSION=true
            break;;
        -h | --help)
            HELP=true
            break;;
        --)
            shift
            break;;
        *)
            break;;
    esac
done

if $HELP;
then
    usage
fi

if $VERSION;
then
    get_version
fi

# Add Docker's official GPG key:
echo "Docker pre-installation steps"
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Beginning Docker installation"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker installation completed"

exit 0
