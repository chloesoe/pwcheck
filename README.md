# pwcheck
Simple script to check your password with the API of haveibeenpwned.com, see
[API reference for Password Range Search][1].  
The script asks you for your password, hashes it with SHA1 and queries the API
to see, if your password already was used and leaked in the database.

[1]: https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange  
