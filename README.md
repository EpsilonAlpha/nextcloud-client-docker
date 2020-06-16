# Nextcloud docker-client
This image provides you an alpine based image for syncing your files with a remote [nextcloud server](https://nextcloud.com/)

This image is based on the work by: [Juan Ignacio Borda](https://github.com/juanitomint)

## Example using local folder

    docker run -it --rm \
      -v $(pwd)/sync-folder:/media/nextcloud \
      -e NC_USER=$username -e NC_PASS=$password \
      -e NC_URL=$server_url\
      stoutyhk/nextcloud-client

## Example using a [named volume](https://docs.docker.com/storage/volumes/)

    docker run -it --rm \
      -v some_named_volume:/media/nextcloud \
      -e NC_USER=$username -e NC_PASS=$password \
      -e NC_URL=$server_url\
      stoutyhk/nextcloud-client

## Example using a named volume and [config files](https://docs.nextcloud.com/desktop/2.6/advancedusage.html#nextcloud-command-line-client)

    docker run -it --rm \
      -v some_named_volume:/media/nextcloud \
      -v some_config_volume:/config \
      -e NC_USER=$username -e NC_PASS=$password \
      -e NC_URL=$server_url\
      stoutyhk/nextcloud-client

The config folder can contain files named:

* `exclude` - this contains files/folders/patterns that you don't want to sync
* `unsyncedfolders` - contains the list of un-synced remote folders (selective sync)

## Example one time run

    docker run -it --rm \
      -v some_named_volume:/media/nextcloud \
      -e NC_USER=$username -e NC_PASS=$password \
      -e NC_URL=$server_url\
      -e NC_EXIT=true\
      stoutyhk/nextcloud-client

replace:

* $username
* $password
* $server_url

 with valid values for an existing and valid user on a Nextcloud Server.

## ENV variables to customize your deploy
##### NC_USER
The user name to log in
Default: username
##### NC_PASS
Valid password for the user above in clear text
Default: password

##### NC_SOURCE_DIR
The directory inside de docker container to be synced, usually you will have a local mount here or a named volume
default: /media/nextcloud/

##### NC_SILENT
whether or not output activity to console
default: false

##### NC_INTERVAL
Sets the interval between syncs in seconds
default: 300 (300 /60 = 5 Minutes)

##### NC_EXIT
If "true" the sync will happen once and then the container will exit, very useful for using in conjunction with cron or schedulers
default: false
example: true
## Advanced settings

##### USER
The system user inside the container you want to use for runing the sync

default: ncsync

##### USER_GUID
The system user group id inside the container you want to use for runing the sync

default: 100

##### USER_UID
The system user id inside the container you want to use for runing the sync

default: 1026

##### NC_TRUST_CERT
whether or not trust self signed certificates or invalid certificates

default: false

##### NC_HIDDEN
whether or not nextcloud should be forced to sync hidden files

default: false

Any comments or problems, feel free to [fill out an issue](https://github.com/jamesstout/nextcloud-client-docker/issues/new) or make a PR!
