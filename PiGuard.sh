#!/bin/bash
############### Device Selection ###############
echo "Select one of the following:"
echo "1. System Configurator"
echo "2. Add Clients"
read UserChoice

############### Sub-menu Selection basted on User Input ###############
#Variables
Install=0
ClientAdd=0

#Logic
if [ $UserChoice = 1 ]
then
    Install=1
elif [ $UserChoice = 2 ]
then
    ClientAdd=1
else
    echo "Error Invalid Input"
fi

############### Installation Options ###############
if [ $Install = 1 ]
then
    echo "Select one of the following:"
    echo "1. Server Configurator"
    echo "2. PiHole Configurator"
    echo "3. Client Configurator"
    read UserChoice

    if [ $UserChoice = 1 ]
    then
        sh ./Server/setup.sh
    elif [ $UserChoice = 2 ]
    then
        sh ./Server/PiHole.sh
    elif [ $UserChoice = 3 ]
    then
        sh ./Client/setup.sh
    else
        echo "Error invalid Input"
    fi
fi

############### Client add Options ###############
if [ $ClientAdd = 1 ]
then
    echo "Select one of the following:"
    echo "1. PC Clients"
    echo "2. Mobile Clients"
    read UserChoice

    if [ $UserChoice = 1 ]
    then
        sh ./Server/addpeer.sh
    elif [ $UserChoice = 2 ]
    then
        sh ./Server/mobileclient.sh
    else
        echo "Error invalid Input"
    fi
fi