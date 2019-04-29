#!/bin/bash
read -s -p "Please enter the password you want to check:" password

printf "\n\n"
echo "INFO: your entered password has `echo -n $password | wc -m` characters"

# convert to SHA1 and create pre- and suffix
mysha="$(echo -n $password | sha1sum | awk '{print toupper($1)}')"
prefix=${mysha:0:5}
suffix=${mysha:5}

# see https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange. Only the
# first 5 characters of are queried to the API. The result is list with the
# suffixes of the found hashes. So we grep for it to see, if our password is
# compromised
printf "\nQuery pwnedpasswords API...\n"
result="$(curl -s https://api.pwnedpasswords.com/range/$prefix | grep $suffix)"

# Check result of grep, if nothing found, password isn't in the list
if [ $? -ne 0 ]
then
    echo "Password not found on api.pwnedpasswords.com"
else
    RED='\033[1;31m'
    NC='\033[0m' # No Color
    appearance=`echo -n ${result} | cut -f2 -d: | sed -e 's/\r//'`
    printf "PW have been seen ${RED} $appearance ${NC} times. ${RED} Don't use ${NC} it!!!\n"
fi
