#!/usr/bin/env bash

conjur policy update -f conjur/seed-generation/body.yml -b conjur/seed-generation
conjur policy update -f conjur/seed-generation/grants.yml -b conjur/seed-generation
