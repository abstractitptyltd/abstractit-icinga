abstractit-icinga
====

[![Build Status](https://travis-ci.org/abstractitptyltd/abstractit-icinga.svg?branch=production)](https://travis-ci.org/abstractitptyltd/abstractit-icinga)

####Table of Contents

0. [Breaking Changes](#changes)
1. [New stuff and bug fixes](#new)
2. [Overview - What is the icinga module?](#overview)
3. [Module Description - What does the module do?](#module-description)
4. [Setup - The basics of getting started with icinga](#setup)
5. [Usage - The parameters available for configuration](#usage)
6. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
7. [Limitations - OS compatibility, etc.](#limitations)
8. [Development - Guide for contributing to the module](#development)
9. [Release Notes - Notes on the most recent updates to the module](#release-notes)

New stuff and bug fixes
-----------------------

I recently started a consulting company called Abstract IT Pty Ltd. I have transfered ownership of all my puppet modules to a new organisation on Puppet Forge called abstractit.
I am making one final release of my modules under rendhalver and abstractit to give you a chance to switch over to the new organisation.
I have also added a licence. All my modules will be licenced under Apache v2.

More fixing changes. We now have officially tested support for Debian and Ubuntu thanks to Josh Holland (@jshholland)

I added support for using ldap auth for the classic web gui and needed to make some changes to the ldap variables.
I have added a new var `$ldap_security` to the params class. This is used to set which security method to use when talking to ldap. Accepted values are tls ssl or none
I have also added vars for setting the base group dn for authentication `$ldap_groupdn`.
The `$ldap_auth_group` is used to tell ldap which group to restrict access to.
You can still use the `$ldap_filter` variable but apache auth may not work and it will be an extra filter to add to auth checking.

I have added support for graphing performance data with pnp4nagios (also published as a module for that as well)
If you don't want this cool feature set `$icinga::params::perfdata` to false and it won't get setup for you.
I also had some issues with access rights in the new gui. Those should be fixed now.
I also fixed an issue with the database port for Postgres not getting set. If it isn't set it will now use the default.
I have also added some fixes for apache 2.4.

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

Using the new web interface

set these options for the database the web interface will use
    $web_db_server = 'mysql',
    $web_db_host = 'localhost',
    $web_db_port = 3306,
    $web_db_name = 'icinga_web',
    $web_db_user = 'icinga_web',
    $web_db_pass = 'icinga_web',

rename your authe scheme if you need to

    $web_auth_name = "user_defined_1",

Set this to chose which auth scheme to use

    $web_auth_type = 'internal',

Valid options are `internal`, `httpbasic`, `ldap` and `none`
Inernal uses the database set about for managing users
httpbasic uses the standard apache auth scheme for getting user details\
ldap uses the options below to setup authentication


set these if you want to use ldap auth via openldap, FreeIPA  or Active Directory

    $ldap_security = tls,
    $ldap_server = "ldap.${domain}",
    $ldap_firstname = 'givenName',
    $ldap_lastname = 'sn',
    $ldap_email = 'mail',
    $ldap_basedn = undef,
    $ldap_binddn = undef,
    $ldap_bindpw = undef,
    $ldap_userattr = uid,
    $ldap_filter_extra = undef,

Implementation
--------------

Uses files based on templates to manage the icinga config files and standard puppet resources fo managing services and such.
I have included some tricky logic to make sure the icinga service on Fedora 18 starts and stops properly.

Limitations
------------

There may be some. Don't hesitate to let me know if you find any.
OS support has only been tested where $osfamily == /(RedHat|Debian)/

Development
-----------

Development team consists of Pete Brown (Abstract IT) (@rendhalver), Josh Holland (@jshholland) and Jason Antman (@jantman).
Additional fixes and help provided by Randy Fay (@rfay) and @slamont.
The module was started by Pete on a whim because I wanted to switch away from nagios.
