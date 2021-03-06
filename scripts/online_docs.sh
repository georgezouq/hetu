#!/bin/bash
current_path=$(pwd)

source ./scripts/util.sh

ENV=$1

if [ ! -n "$ENV" ]; then
    ENV="test"
fi

echo "开始打包docs, 打包环境为 $ENV"

rm -rf ./dist/site
rm -rf ./plugin/_site
mkdir -p dist/site

echo "install components deps"
cd ./plugin
yarn
echo "build components"
yarn build
echo "build components success"

echo "install site deps"
cd ./site 
yarn
echo "build site source"
cd ..
yarn build:site

echo "build success"
cd ..

cp -R -f plugin/_site/* dist/site/
echo "build end"

echo "push source"
scp -r dist/site/* $ACCOUNT:/data/www/hetu-doc
echo "push success"
