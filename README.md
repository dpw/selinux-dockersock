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

Make sure you have the prerequisite SELinux utilities by doing (on
RHEL/CentOS/Fedora/etc.):

    yum install policycoreutils policycoreutils-python checkpolicy

Then as root, just do

    make

Or if you are paranoid, without being root you can do

    make dockersock.pp

to build the SELinux policy module package, and then load it as root
with

    semodule -i dockersock.pp

Should you ever wish to remove the module, do

    semodule -r dockersock
