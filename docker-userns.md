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


* For RHEL or CentOS 7.4-, Enable user namespaces on the RHEL7 host:
  ```bash
  grubby --args="user_namespace.enable=1" --update-kernel="$(grubby --default-kernel)"
  reboot
  ```
* For RHEL or CentOS 7.5+, you need to do the following:

  * Remove user_namespace.enable=1 kernel parameter:
  ```bash
  grubby  --remove-args="user_namespace.enable=1" --update-kernel=/boot/vmlinuz-3.10.0-693.5.2.el7.x86_64
  ```
  * Add the new parameter:
  ```
  grubby --args="namespace.unpriv_enable=1" --update-kernel=/boot/vmlinuz-3.10.0-693.5.2.el7.x86_64
  ```
  * Add a line to ``/etc/sysctl.conf``:
  ```bash
  sudo cat >> /etc/sysctl.conf
  user.max_user_namespaces=1507
  ```
  * Execute the below set of commands:
  ```bash
  echo "sysctl --system /etc/sysctl.d" >> /etc/rc.d/rc.local
  chmod 755 /etc/rc.d/rc.local
  ```
  * Reboot the node after making the change

* Access your VM again, when it is up, then modify the ``ExecStart`` attribute in ``/usr/lib/systemd/system/docker.service``:
```bash
ExecStart=/usr/bin/dockerd --userns-remap=default
```
* Restart the Docker service:
```bash
sudo service docker restart
```
* test that the container root is remapped. Run a sleep process in a Docker container and verify that the container root is remapped to 500000:
```bash
docker run -d -it centos sleep 100
ps -ef | grep sleep
500000    2970  2953  0 19:29 pts/1    00:00:00 sleep 100
root      2990  2593  0 19:30 pts/0    00:00:00 grep --color=auto sleep
```
