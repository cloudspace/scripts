#!/bin/bash

set -ex

git submodule update --init --recursive
git submodule foreach '(git checkout master && git pull --rebase) || echo "Not attempting to sync"'
if [ ".$@" == "." ]; then
    ./mvnw clean install -P build,!base,!starters,!apps -DskipTests
    ./mvnw clean install -P !build,base,starters,!apps -DskipTests
fi
./mvnw clean install "$@" -DskipTests
