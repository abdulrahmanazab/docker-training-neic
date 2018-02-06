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
4. Now go to [Docker hub](hub.docker.com) and link your Docker hub account to your ``bowtie2-test`` git repo
5. In the *build settings* tab, trigger a new build, then keep an eye on the *Build details* tab
6. Once the build is done, check the build details. If successful, make sure that the Dockerfile contents are copied in the *Dockerfile* tab
