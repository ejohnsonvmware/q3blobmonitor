#!/bin/bash

url="http://blobs.vmwaredevops.appspot.com/api/v1/blobs/10"
errorurl="http://localhost:18081/error"
content=`/usr/bin/curl -s ${url} | python -c "import sys, json; print json.load(sys.stdin)['content']"`
origmd5=`echo ${content} | md5sum`

echo "Orignal MD5: $origmd5"

while [ 1 ]
do

  content=`/usr/bin/curl -s ${url} | python -c "import sys, json; print json.load(sys.stdin)['content']"`
  md5=`echo ${content} | md5sum`


  if [ "${origmd5}" != "${md5}" ]
  then
    echo "Blob changed"
    echo "[DEBUG] start=$origmd5 current=$md5"
    curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 2184b222-1cb8-9669-ed6a-1ed4750b31e8" -d '{ "service": "postman","message": "Blob file changed" }' ${errorurl}
    md5orig=$md5
  else
    echo "[DEBUG] md5=$md5"

  fi
  sleep 5 
done
