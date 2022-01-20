# pwcheck
Bash script to check your password with the API of haveibeenpwned.com, see
[API reference for Password Range Search][1].
The script asks you for your password, hashes it with SHA1 and queries the API
to see, if your password already was used and leaked in the database.


## How to use

1. Clone repo
    ```
    git clone git@github.com:chloesoe/pwcheck.git && cd pwcheck
    # or
    git clone https://github.com/chloesoe/pwcheck.git && cd pwcheck
    ```
2. run the bash script:
    ```
    ./password-check.sh 
    Please enter the password you want to check:
 
    INFO: your entered password has 12 characters
 
    Query pwnedpasswords API...
    PW have been seen  12  times.  Don't use  it!!
    ```


## How it works

Only the first 5 characters of are queried to the API. The result is list with
the suffixes of the found hashes. The script greps for it to see, if the
entered password is compromised.
See [API reference for Password Range Search][1].


[1]: https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange
