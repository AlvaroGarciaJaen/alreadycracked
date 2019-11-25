#!/bin/bash 

az webapp delete --name alreadycracked
az appservice plan delete --name IVPlan
az group delete --name IV
