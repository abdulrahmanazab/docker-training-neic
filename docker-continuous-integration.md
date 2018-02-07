# Docker Continuous Integration

This is a Docker automated build tutorial

Build on Docker Hub
--------------------
1. Go to [Github](github.com) and sign in if you already have an account or sign up if not.
2. Create a new github repo and name it ``bowtie2-test``
3. In the ``bowtie2-test`` repo, create a new file, name it ``Dockerfile`` and fill it with the following:

```bash
FROM ubuntu:14.04 
RUN apt-get update -qq --fix-missing; \ 
	apt-get install -qq -y wget unzip; 
RUN wget -q -O bowtie2.zip http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.4/bowtie2-2.2.4-linux-x86_64.zip/download; \ 
	unzip bowtie2.zip -d /opt/; \ 
	ln -s /opt/bowtie2-2.2.4/ /opt/bowtie2; \ 
	rm bowtie2.zip 
ENV PATH $PATH:/opt/bowtie2 
```
4. Now go to [Docker hub](hub.docker.com), link your Docker hub account to your ``bowtie2-test`` git repo 
5. In the *build settings* tab, trigger a new build, then keep an eye on the *Build details* tab
6. Once the build is done, check the build details. If successful, make sure that the Dockerfile contents are copied in the *Dockerfile* tab
7. Go to *settings* tab, and make the repo public
8. Go to your VM and run ``docker search <your-docker-id>`` and you get an output like this:
```bash
NAME                             DESCRIPTION                         STARS           OFFICIAL            AUTOMATED
usit/bowtie2                     bowtie2 test                        0                                   [OK]
```
9. Now test your bowtie2 image. run ``docker run --rm <your-docker-id>/bowtie2 bowtie2 --version``
```bash
Unable to find image '<your-docker-id>/bowtie2-test:latest' locally
latest: Pulling from <your-docker-id>/bowtie2-test
c954d15f947c: Already exists
c3688624ef2b: Already exists
848fe4263b3b: Already exists
23b4459d3b04: Already exists
36ab3b56c8f1: Already exists
2025c15309ef: Pull complete
b7bbb25b5ed0: Pull complete
Digest: sha256:ef7a5e9df7e76ea294a6bd999393fca747d4b41e7f4b08a51c18d8bb4f273c71
Status: Downloaded newer image for <your-docker-id>/bowtie2-test:latest
/opt/bowtie2/bowtie2-align-s version 2.2.4
64-bit
Built on localhost.localdomain
Wed Oct 22 12:35:49 EDT 2014
Compiler: gcc version 4.1.2 20080704 (Red Hat 4.1.2-54)
Options: -O3 -m64 -msse2  -funroll-loops -g3 -DPOPCNT_CAPABILITY
Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}
```
Automated build
----------------
10. Go to your ``bowtie2-test`` github repo and modify the Dockerfile (upgrading the bowtie2 version to 2.3.4):
```bash
FROM ubuntu:14.04 
RUN apt-get update -qq --fix-missing; \ 
	apt-get install -qq -y wget unzip; 
RUN wget -q -O bowtie2.zip http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.4/bowtie2-2.3.4-linux-x86_64.zip/download; \ 
	unzip bowtie2.zip -d /opt/; \ 
	ln -s /opt/bowtie2-2.3.4-linux-x86_64/ /opt/bowtie2; \ 
	rm bowtie2.zip 
ENV PATH $PATH:/opt/bowtie2 
```
11. Now go to your docker hub repo, the *Build details* tab, and notice that a new build has been triggered
12. After the build is completed, go to your VM and again run ``docker run --rm <your-docker-id>/bowtie2-test bowtie2 --version``
```bash
Unable to find image '<your-docker-id>/bowtie2-test:2.3.4' locally
2.2.4: Pulling from <your-docker-id>/bowtie2-test
c954d15f947c: Already exists
c3688624ef2b: Already exists
848fe4263b3b: Already exists
23b4459d3b04: Already exists
36ab3b56c8f1: Already exists
c3a5acaf53e8: Pull complete
09c4c210758b: Pull complete
Digest: sha256:11c1615911d570cd55eea38f3a1e894a977a1b6efd599fdb4d71b89a3fa5f075
Status: Downloaded newer image for <your-docker-id>/bowtie2-test:2.3.4
/opt/bowtie2/bowtie2-align-s version 2.3.4.1
64-bit
Built on 14231912a8bd
Sat Feb  3 13:04:04 UTC 2018
Compiler: gcc version 4.8.2 20140120 (Red Hat 4.8.2-15) (GCC)
Options: -O3 -m64 -msse2 -funroll-loops -g3 -g -O2 -fvisibility=hidden -I/hbb_exe/include  -std=c++98 -DPOPCNT_CAPABILITY -DWITH_TBB -DNO_SPINLOCK -DWITH_QUEUELOCK=1
Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}
```
Notice that only the two upper layers were pulled, while the other layers already existed

Multiple tags
--------------
* create another branch on the github repo, e.g. ``2.3.3``, and modify the Dockerfile accordingly
* In the Docker hub page, configure another build with the newly created branch and trigger it
* On your VM, run ``docker pull -a <your-docker-id>/bowtie2-test`` and notice that two images with two tags are pulled

Privacy
--------
* In the Docker hub page, make ``<your-docker-id>/bowtie2-test`` *private*
* Now on your VM, try to search for this repo. Not there, right? Now try to pull the image again
```bash
$ docker pull -a <your-docker-id>/bowtie2-test
Using default tag: latest
Error response from daemon: pull access denied for <your-docker-id>/bowtie2-test, repository does not exist or may require 'docker login
```
* It is now private, and requires *login*. Now login and try again
```bash
$docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: <your-docker-id>
Password: <your-password>
Login Succeeded

$docker pull <your-docker-id>/bowtie2-test
Using default tag: latest
latest: Pulling from <your-docker-id>/bowtie2-test
c954d15f947c: Already exists
c3688624ef2b: Already exists
848fe4263b3b: Already exists
23b4459d3b04: Already exists
36ab3b56c8f1: Already exists
f481c2f4b7bc: Pull complete
b99a74a85307: Pull complete
Digest: sha256:45f58aecfe190eb57883e56a60e41c0a6c075e32ee13d82cba018e1481b8339a
Status: Downloaded newer image for <your-docker-id>/bowtie2-test:latest
```
* Also notice that the repo is now not searchable on the Docker hub website

Add Collaborators
------------------
* If you add a collaborator (another docker account) to a private repo, the repo will be visible to that account. Try this out!
