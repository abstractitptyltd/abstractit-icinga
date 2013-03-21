icinga
====

####Table of Contents

1. [Overview - What is the icinga module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with icinga](#setup)
4. [Usage - The parameters available for configuration](#usage)
5. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

Overview
--------

Puppet module for managing an icinga server.

Module Description
------------------

Manages icinga and the extra service for icinga.
It uses the standard locations the `nagios_*` resources get imported into.
Like the ones my monitoring module sets up.

Setup
-----

**what icinga affects:**

* the icinga service
* config files for icinga
* ido2db service and ido config

### Beginning with icinga

This will install icinga and set it up.
It will also include apache and the other necessicary modules.

    include icinga

Usage
-----


Defaults for vars to set if you need them.
These are class params so use hiera or and ENC to set them up easily.

    $web_ip = $ipaddress
    $web_port = 443
    $ssl = true
    $webhostname = $fqdn
    $notifications = 1
    $embedded_perl = 0
    $admin_group = undef
    $admin_users = undef
    $ro_users = undef
    $ro_group = undef
    $check_timeout = 180
    $ido_db_server = 'mysql'
    $ido_db_host = 'localhost'
    $ido_db_port = 3306
    $ido_db_name = 'icinga'
    $ido_db_user = 'icinga'
    $ido_db_pass = 'icinga'
    $debug = 0
    $admin_email = 'icinga@localhost'
    $admin_pager = 'pageicinga@localhost'
    $stalking = 0
    $flap_detection = 1

I don't do any database setup at the moment so please make sure the database exist and the user you set has access to it.
Initial sql for the database is here /usr/share/doc/icinga-idoutils-libdbi-(mysql|pgsql)-$icingaversion/db/(mysql|pgsql)/(mysql|pgsql).sql
Please set that up before you start the service.
You will also need to install icinga, icinga-doc, icinga-gui and icinga-idoutils-libdbi-(mysql|pgsql) or have them in a repository your node has access to.

extra settings

    $nagios_extra_plugins = hiera('monitoring::params::nagios_extra_plugins', undef)
    $db_password = hiera('monitoring::db_password')
    $email_user = hiera('monitoring::email_user')
    $email_password = hiera('monitoring::email_password')
    $ssl_cert_source = hiera('ssl_cert_source')


Implementation
--------------

Uses files based on templates to manage the icinga config files and standard puppet resources fo managing services and such.
I have included some tricky logic to make sure the icinga service on Fedora 18 properly.

Limitations
------------

There may be some. Don't hesitate to let me know if you find any.

Development
-----------

All development, testing and releasing is done by me at this stage.
If you wish to join in let me know.

Release Notes
-------------

**1.0.3**

Switching to puppetlabs/apache for managing the apache vhost
Added Postgres setup.
Automagically set the port for postgresql.
Tricky logic ot make sure the services work as expected on Fedora using systemd.
Install the appropriate database package if postgresql is needed
Change the host file to grab the vars via lookupvar instead.

**1.0.2**

fixing some site specific setup options

**1.0.1**

fixing var name in config class

**1.0.0**

Initial release
