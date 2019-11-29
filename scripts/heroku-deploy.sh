#!/bin/bash

heroku create alreadycracked --region eu
heroku stack:set container
heroku container:push web
heroku container:release web
