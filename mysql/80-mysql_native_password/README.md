This image was needed after hours of testing trying to connect bitbucket pipelines with the deafult mysql:8.0 image.

Somehow we are not able to connect to the database bash with commands like this:

```
mysql -uroot -p'redirection-pass' -h127.0.0.1 -e 'GRANT ALL ON *.* TO "redirection-usr"@"%"'
ERROR 1045 (28000): Plugin caching_sha2_password could not be loaded: Error loading shared library /usr/lib/mariadb/plugin/caching_sha2_password.so: No such file or directory
 
```

So, after googling and testing seems like we have to enable the native authentication plugin for mysql. 

This is only for testing purposes, we should not use this image in production.

This image is used on pipelines currently.