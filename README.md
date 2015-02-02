# selinux-dockersock

A nice trick with docker is to mount the docker daemon's unix socket
into a container, so that container can act as a client to the docker
daemon it is running under, e.g.:

   docker run ... -v /var/run/docker.sock:/var/run/docker.sock

But this doesn't work with Fedora or RHEL as the host because of their
use of SELinux to harden containers.  When the docker client attempts
to access `/var/run/docker.sock` within the container, you'll get
"Permission denied" errors.

This repo contains a small SELinux module that fixes this issue,
allowing containers to access the socket.

## Usage

As root, just do

    make

Or if you are paranoid, you can do

    make dockersock.pp

to build the SELinux policy module package, and then load it with

    selinux -i dockersock.pp
