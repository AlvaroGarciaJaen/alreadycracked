#!/bin/bash 

az group create --name IV --location westeurope
az configure --defaults group=IV
az appservice plan create --name IVPlan --sku F1 --location westeurope --is-linux
az webapp create -p IVPlan -n alreadycracked -i alvaronetwork/alreadycracked
az webapp deployment container config --enable-cd true --name alreadycracked
