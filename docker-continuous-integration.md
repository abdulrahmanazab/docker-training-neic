# Docker Continuous Integration

This is a Docker automated build tutorial

Greate a github account
------------------------
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
NAME                             DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
usit/bowtie2                     bowtie2 test                                    0                                       [OK]
```
9. Now test your bowtie2 image. run ``docker run --rm usit/bowtie2 bowtie2 --version``
```bash
Unable to find image 'usit/bowtie2:latest' locally
latest: Pulling from usit/bowtie2
c954d15f947c: Already exists
c3688624ef2b: Already exists
848fe4263b3b: Already exists
23b4459d3b04: Already exists
36ab3b56c8f1: Already exists
2025c15309ef: Pull complete
b7bbb25b5ed0: Pull complete
Digest: sha256:ef7a5e9df7e76ea294a6bd999393fca747d4b41e7f4b08a51c18d8bb4f273c71
Status: Downloaded newer image for usit/bowtie2:latest
/opt/bowtie2/bowtie2-align-s version 2.2.4
64-bit
Built on localhost.localdomain
Wed Oct 22 12:35:49 EDT 2014
Compiler: gcc version 4.1.2 20080704 (Red Hat 4.1.2-54)
Options: -O3 -m64 -msse2  -funroll-loops -g3 -DPOPCNT_CAPABILITY
Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}
```
