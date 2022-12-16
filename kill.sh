#!/usr/bin/env bash
#docker-compose -f docker-compose.yml down -v
docker-compose stop
docker-sync stop
docker-compose down -v
docker-sync clean