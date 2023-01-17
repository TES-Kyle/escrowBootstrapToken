# escrowBootstrapToken

Used to install escrowed token to capable machines

Usage instructions are kind of rough around the edges

Use Encrypted Strings project to encrypt your password by (https://github.com/brysontyrrell/EncryptedStrings/blob/master/EncryptedStrings_Bash.sh):

Copy and paste the WHOLE "GenerateEncryptedString()" function into terminal and hit return Type "GenerateEncryptedString PASSWORD" and replace PASSWORD with the password you'd like to encrypt. Escape spaces and other characters as needed with a backslash

It will return a passphrase, salt, and hash. The salt and hash should be hardcoded into the script and the passphrase should be passed as parameter 5 in a jamf policy

Parameter 4 is used for the admin account you wish to use.

THIS REQUIRES THE ADMIN USER YOU USE HAS A SECURE TOKEN.
