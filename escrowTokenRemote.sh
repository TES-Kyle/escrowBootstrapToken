#!/bin/bash

# Kyle
# Created 1/12/2023
# Sources:
# https://community.jamf.com/t5/jamf-pro/ensuring-bootstrap-tokens-are-enabled-and-functional-on-macos-10/m-p/232998
# https://github.com/brysontyrrell/EncryptedStrings/blob/master/EncryptedStrings_Bash.sh

function DecryptString() {
    # Usage: ~$ DecryptString "Encrypted String" "Salt" "Passphrase"
    #echoFunc "about to decrypt"
    echo "${1}" | /usr/bin/openssl enc -aes256 -md md5 -d -a -A -S "${2}" -k "${3}"
    #echo "Salt: ${2}, Hash: ${3}"
    #echoFunc "Decrypted!"
}

# Parameter 4 on jamf script pane
adminUser=$4

# Uses the passphrase passed from parameter 5 on jamf script pane
adminUserPassword=$(DecryptString ${5} **SALT** ****HASH****)

#echo "$adminUserPassword"

#Create an EXPECT file to deal with interactive portion of bootstrap tokens
/bin/cat << EOP > /Library/Application\ Support/JAMF/tmp/escrowToken
#! /usr/bin/expect

set adminName "[lindex \$argv 0]"
set adminPass "[lindex \$argv 1]"

#This will create and escrow the bootstraptoken on the Jamf Pro Server

spawn /usr/bin/profiles install -type bootstraptoken

expect "Enter the admin user name:" 
send "\$adminName\r"
expect "Enter the password for user '\$adminName':" 
send "\$adminPass\r"
expect eof

exit 0
EOP

# Give script execute permissions
chmod +x /Library/Application\ Support/JAMF/tmp/escrowToken

# Pass arguments to EXPECT script
/Library/Application\ Support/JAMF/tmp/escrowToken "$adminUser" "$adminUserPassword"

# Remove script after completion
rm -rf /Library/Application\ Support/JAMF/tmp/escrowToken
