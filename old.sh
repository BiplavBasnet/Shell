#!/bin/bash

# Generate data file
echo "This is some sensitive data." > data.txt

# Generate a digital signature
openssl dgst -sha256 -sign basnet.key -out signature.txt data.txt

# Encrypt the data
openssl enc -aes-256-cbc -salt -in data.txt -out encrypted_data.enc -pass pass:villane

# Transfer the files to the recipient's machine
scp encrypted_data.enc signature.txt kali@192.168.165.3:/home/kali/folder1

# Decrypt the data on the recipient's machine
scp kali@192.168.165.3:/home/kali/folder1/encrypted_data.enc /tmp/
openssl enc -d -aes-256-cbc -in /tmp/encrypted_data.enc -out /tmp/decrypted_data.txt -pass pass:hero

# Verify the signature
scp kali@192.168.165.3:/home/kali/folder1/signature.txt /tmp/
openssl dgst -sha256 -verify public.basnet -signature /tmp/signature.txt /tmp/decrypted_data.txt
