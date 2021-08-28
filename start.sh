#!/bin/bash

FILENAME=docker-compose.yml
if [ "$1" = "pro" ]
then
  FILENAME=docker-compose.pro.yml
fi

docker-compose -f $FILENAME up