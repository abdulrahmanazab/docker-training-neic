
# Containers workshop material NORBIS Summer School 2018

The training infrastructure is offered by [cPouta](https://research.csc.fi/cpouta) at CSC, Finland.

Connect to your VM
--------------------
* You will get the key file ``docker-tutorial.pem`` from your instructor
* Now use it to connect to your VM:
```bash
chmod 600 docker-tutorial.pem 
ssh -i docker-tutorial.pem cloud-user@<Terminal-IP-Address>
[cloud-user@docker-tutorial-terminal ~]$ ssh -i docker-tutorial.pem cloud-user@<your-VM-name>
```
Tutorial contents
------------------
* [Docker](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-ws-2018/docker.md)

Extra (if we have time):
* [Docker on HTCondor](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-ws-2018/docker-htcondor.md)
* [Singularity](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-ws-2018/singularity.md)
