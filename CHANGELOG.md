##2014-03-27 - Pete Brown <pete@abstractit.com.au> 1.2.2
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

####Known bugs
* No known bugs. Please let us know if you find any.

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

