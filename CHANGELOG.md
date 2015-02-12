##2015-02-12 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc11
###Summary
Bugfix Release

####Bugfixes
Classic gui needs mod cgi

####Known bugs
* No known bugs. Please let us know if you find any.


##2015-02-12 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc10
###Summary
Bugfix Release

####Bugfixes
Make sure classic gui actually uses auth
It wasn't even including it at all.


##2015-02-05 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc9
###Summary
Bugfix Release

####Bugfixes
make sure pid files are actually owned by the user running the process
added requires so packages are installed before config files get setup


##2015-01-23 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc8
###Summary
Bugfix Release

####Features
add variable for enabling and disabling ido
switched to new module loading setup for icinga brokers
manage defaults and init files for icinga and ido2db
use new enable_ido variable to enable iso2db service and load module

####Bugfixes
fix ido and perfdata setup
fix class dependencies
fix location of embeded perl binary
fix lockfile location for ido2db


##2015-01-23 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc7
###Summary
Bugfix Release

####Bugfixes
Fixing location of pnp4nagios proker lib


##2015-01-23 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc6
###Summary
Bugfix Release

####Bugfixes
Added requires for confir files so the packages get installed first.
Add apache::mod::rewrite so the rewrites work for ther web gui
Now requires stdlib 4.5.1 so include security patches.
Also requires apt 1.7.0


##2015-01-22 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc5
###Summary
Bugfix Release

####Bugfixes
Fixing project_page link
Updating changelog with recent releases
Fix config for new web gui (it requires mod_rewrite)


##2015-12-15 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc4
###Summary
Bugfix Release

####Bugfixes
new apache includes apache mod authn_file


##2014-12-04 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc3
###Summary
Bugfix Release

####Bugfixes
Requiring version 1.2.0 of puppetlabs-apache module
Fixing travis link
Fixing apache class setup @gerapeldoorn


##2014-07-26 - Pete Brown <pete@abstractit.com.au> 1.2.2-rc2
###Summary
Bugfix Release
Updating to work with new apache module
Also migrating to Abstract IT from rendhalver.
Moving Changelog into it's own markdown file
Many changes to make the module more independent.
Added a users class to make sure users exist for icinga.
Added official repository for icinga.

####Bugfixes
- Style guide fixes.
- fixing bugs resulting from reliance on my monitoring modules.


---
##### 2013-07-23 - Pete Brown <pete@abstractit.com.au> - 1.2.1

 * Merging in more fixes from Josh Holland
 * switching to `ensure_packages` for package installs

##### 2013-07-02 - Pete Brown <pete@abstractit.com.au> - 1.2.0

 * Support for Debian/Ubuntu provided by  Josh Holland (@jshholland on Github)
 
##### 2013-04-02 - Pete Brown <pete@abstractit.com.au> - 1.1.0

 * Adding performance data processing with pnp4nagios.
 * Added ldap auth for clasic gui.
 * Fixed a bunch of bugs.

##### 2013-04-02 - Pete Brown <pete@abstractit.com.au> - 1.0.6

 * Adding the option of setting up the new web interface and or the classic one

##### 2013-03-22 - Pete Brown <pete@abstractit.com.au> - 1.0.5

 * Adding option to set which gui to use, "none" dosen't setup the gui
 * Fixing name of service for apache


##### 2013-03-21 - Pete Brown <pete@abstractit.com.au> - 1.0.4

 * Adding option to turn off firewall management

##### 2013-03-08 - Pete Brown <pete@abstractit.com.au> - 1.0.3

 * Switching to puppetlabs/apache for managing the apache vhost
 * Added Postgres setup.
 * Automagically set the port for postgresql.
 * Tricky logic ot make sure the services work as expected on Fedora using systemd.
 * Install the appropriate database package if postgresql is needed
 * Change the host file to grab the vars via lookupvar instead.

##### 2013-01-18 - Pete Brown <pete@abstractit.com.au> - 1.0.2

 * fixing some site specific setup options

##### 2013-01-18 - Pete Brown <pete@abstractit.com.au> - 1.0.1

 * Fixing var name in config class.

##### 2013-01-16 - Pete Brown <pete@abstractit.com.au> - 1.0.0

 * Initial Release

