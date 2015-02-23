# perl-io-crypt-rsa

A helper module needed to asymmetrically encrypt/decrypt large files using RSA keys

## Using keys

This module depends on asymmetric keys in PEM format. These might be 
generated using the following commands: 

    $ openssl genrsa -out rsa.pem 2048
    $ openssl rsa -in rsa.pem -pubout > rsa.pub

