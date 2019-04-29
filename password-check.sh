#!/bin/bash
read -s -p "Please enter the password you want to check:" password

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
    appearance=`echo -n ${result} | cut -f2 -d: | sed -e 's/\r//'`
    echo "PW have been seen $appearance times. Don't use it!!!"
fi
