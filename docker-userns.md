# Docker with user namespaces

First, verify that user namespaces are enabled on the kernel. There are many popular but inaccurate way to do this. the accurate way is to verify that ``/proc/self`` exists. Note that rhel7 with kernel 3.10.x supports user namespaces, while centos7 with the same kernel version doesn't:
* Become root:
```bash
$ sudo -i
```
* Add a new user dockremap (yes dockremap not dockermap):
```bash
useradd dockremap
```
* Create subuid and subgid files with the user and group id remap ranges:
```bash
echo dockremap:500000:65536 > /etc/subuid
echo dockremap:500000:65536 > /etc/subgid
```
For this mapping, root (UID 0) will be mapped to UID 500000
* Enable user namespaces on the RHEL7 host, then reboot:
```bash
grubby --args="user_namespace.enable=1" --update-kernel="$(grubby --default-kernel)"
reboot
```
* Access your VM again, when it is up, then modify the ``ExecStart`` attribute in ``/usr/lib/systemd/system/docker.service``:
```bash
ExecStart=/usr/bin/dockerd --userns-remap=default
```
* test that the container root is remapped. Run a sleep process in a Docker container and verify that the container root is remapped to 500000:
```bash
docker run -d -it centos sleep 100
ps -ef | grep sleep
500000    2970  2953  0 19:29 pts/1    00:00:00 sleep 100
root      2990  2593  0 19:30 pts/0    00:00:00 grep --color=auto sleep
```
