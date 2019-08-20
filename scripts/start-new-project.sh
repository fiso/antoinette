#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 project-slug destination-folder"
  exit
fi

projectslug=$1
destinationfolder=$2

foundnvm=false

if [ -f ~/.nvm/nvm.sh ]; then
  source ~/.nvm/nvm.sh
  foundnvm=true
elif [ $(which brew) ]; then
  source $(brew --prefix nvm)/nvm.sh
  foundnvm=true
fi

mkdir -p $destinationfolder
git archive -o $destinationfolder/head.zip -9 HEAD
cd $destinationfolder
unzip head.zip
rm head.zip
git init

sed -i "" -e "s/\"antoinette\"/\"$projectslug\"/g" "package.json"

if [ $foundnvm ]; then
  nvm install
  nvm use
  npm install
fi
