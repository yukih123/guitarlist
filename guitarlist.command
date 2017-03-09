#!/bin/sh
cd `dirname $0`

url=$1
if [ -z "$url" ]
then
  echo "Enter the url:"
  read url

  if [ -z "$url" ]
  then
    exit 0
  fi
fi

url=${url%/*.php}
dir=${url##*/}

mkdir $dir
cd $dir

i=1
while [ `curl -I ${url}/img/${i}.png -o /dev/null -w '%{http_code}\n' -s` -ne 302 ]
do
  curl -O -f ${url}/img/${i}.png
  i=`expr $i + 1`
done
