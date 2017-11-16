# create-db-users-using-bashscript
bash-create-db-user
===================

bash-create-db-users script is a bash script, which can be used to automate local and cloud to create users in Linux/Unix machines.

RELEASE 0.1.0 (05 Nov 2017)

Features
--------

* bash-create-db-user - Create all db users access details separately with multiple different role
* supported databases
    * MySQL
* You can enable the delete user options also, Once the user is created you can delete those user immediately.
* User access detail files are stored in specified directory.

License
-------
MIT (see https://opensource.org/licenses/MIT)

Configuration file
-------------------
* ``config.conf``: Script will use the configuration from this file (optional)

Scripts
-------

* ``bash-create-db-user.sh``: the main script

You may create and use custom scripts (see below - Configuration)


Setup using git (recommended)
-----------------------------
### installation

    cd /path/to/scripts
    git clone https://github.com/anilskalyane/bash-create-db-user.git

### get updates

    cd /path/to/scripts/bash-cloud-backup
    git fetch
    git merge origin


Setup by download
-----------------

If ``git`` is not available, download the source:

https://github.com/anilskalyane/bash-create-db-user/archive/master.zip

### Directories

``bash-create-db-user`` will create all directories you define in configuration files (assuming it has the required permissions)


Security
--------

### About MySQL password

DO NOT expose ``root`` password to create users. Create a 'grant only' user for create and grant purposes.
