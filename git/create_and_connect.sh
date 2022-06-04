#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: ./create_and_connect.sh <PATH TO LOCAL REPOSITORY> <REMOTE REPOSITORY ADDRESS>"
    exit 1
fi

cd $1
git init --initial-branch=main
git remote add origin $2
git add .
git commit -m "Initial commit"
git push -u origin main
