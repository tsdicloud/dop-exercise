#!/bin/bash

for id in {01..15}
do
    sudo useradd --create-home devops$id --groups users,docker --password \
    `python -c "import crypt;print(crypt.crypt('"$1"'))"`
done
