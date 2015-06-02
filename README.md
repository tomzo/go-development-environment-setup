Go development environment setup
================================

These scripts will setup a virtual machine, with all the dependencies needed to build Go.


Dependencies
------------

1. Vagrant 1.4 or higher (http://www.vagrantup.com/)
2. VirtualBox 4.3.4 or higher (https://www.virtualbox.org/)


First time setup - Linux / Mac
------------------------------

To setup the development environment without a GUI window manager (Gnome) and an IDE, do this:
> ./setup.sh

OR

To setup the development environment with a GUI window manager (Gnome) and an IDE, do this:
> ./setup.gui.sh


First time setup - Windows
--------------------------

To setup the development environment without a GUI window manager (Gnome) and an IDE, do this:
> ./setup.bat

OR

To setup the development environment with a GUI window manager (Gnome) and an IDE, do this:
> ./setup.gui.bat


Subsequent runs
---------------

Running one of the above setup scripts should automatically log you into the virtual machine (using VirtualBox) environment and give you a shell (when run without a GUI) or an IDE (when run with GUI). Suppose you bring the virtual machine down and you want to bring it up at a later time, you can do this:
> vagrant up

You can bring down the virtual machine, keeping all your work intact, by doing this:
> vagrant halt

OR

> vagrant suspend


Creating a brand new instance
-----------------------------

You can get rid of an already existing box and create a brand new environment by doing:
> vagrant destroy

And then running one of the first time setup steps again.

> Note: The process of first time setup can take a really long time (a minimum of 40-60 minutes on a good connection).


More information
----------------

Credentials for the virtual machine are:

  Username: vagrant

There is currently no password for this user. You can set the password using the comand `passwd` for user *vagrant*.


Go development environment in docker
====================================

> berks package cookbooks.tar.gz

> docker build .
