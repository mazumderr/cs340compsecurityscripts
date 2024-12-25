#!/usr/bin/env bash

target="$1"                       # the tag we are looking for
dictionary="$2"                   # dictionary to parse

if [[ $# < 2 ]]                   # must provide 2 args
		                              # 1 for tag, 2 for keys
then
   echo "usage: ./brute_pw_attack.sh [HMAC TAG] [PATH_TO_DICTIONARY]"
   exit 1
fi
while read key
do
   tag=$(openssl dgst -sha1 -hmac ${key} "unverified/whiskey.jpg")
   if [[ $tag == *"$target"* ]]                                     # check to see if the command output contains
				                                                            # the target tag we are looking for
   then
     echo "The key is \033[32m${key}\033[0m"             # ANSI escape sequence
     exit
   fi
done < $dictionary                                      # dictionary we want to loop over, line by line

echo "\033[31mKey not found!\033[0m"                   # if key not found output error
