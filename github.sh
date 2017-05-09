#!/bin/bash
#curl -u 'USER' https://api.github.com/user/repos -d '{"name":"REPO"}'
#curl -X DELETE -u 'lixingzh' https://api.github.com/repos/lixingzh/github-cmdline-create-test
USER="lixingzh"
QUERY="-u $USER"

function help {
   echo "Format:"
   echo "   -c [ARG]: create new repo with name ARG"
   echo "   -d [ARG]: delete repo with name ARG"
   echo "   -l : get list of repos of user"
   echo ""
   echo "HOWTO: add remote repo example:"
   echo "git init"
   echo "git add ."
   echo "git commit -m \"comments\""
   echo "git remote add origin https://github.com/lixingzh/Lixing_Lib.git"
   echo "git push -u origin master"
   exit 1
}

if [ $# == 0 ]; then
   echo "No args received" >&2
   help
fi

while getopts ":c:u:d:l" opt; do
   case $opt in
   c)
      QUERY+=" https://api.github.com/user/repos -d {\"name\":\"$OPTARG\"}"
      echo $QUERY
   ;;
   d)
      QUERY+=" -X DELETE https://api.github.com/repos/$USER/$OPTARG"
      echo $QUERY
   ;;
   l)
      QUERY+=" -X GET https://api.github.com/user/repos"
      echo $QUERY
   ;;
   u)
      USER=$opt
      echo "change USER to $USER"
   ;;
   \?)
      echo "Invalid argument -$OPTARG"
      help 
   ;;
   :)
      echo "Missing parameter $OPTARG"
      help
   ;;
   esac
done

curl $QUERY
