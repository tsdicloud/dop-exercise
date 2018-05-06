#!/bin/bash

for id in {01..15}
do
    sudo userdel --force --remove devops$id
done
