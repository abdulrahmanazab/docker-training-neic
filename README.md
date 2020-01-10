
# Containers Tutorial - Research Bazaar, Oslo 2020

The training infrastructure is offered by [cPouta](https://research.csc.fi/cpouta) at CSC, Finland.

Connect to your VM
--------------------
* You will get the key file ``docker-tutorial.pem`` from your instructor
* Now use it to connect to your VM:
```bash
chmod 600 docker-tutorial.pem 
ssh -i docker-tutorial.pem cloud-user@<Terminal-IP-Address>
[cloud-user@docker-tutorial-terminal ~]$ ssh -i docker-tutorial.pem cloud-user@container-tutorial-[1-16]
```
Tutorial contents
------------------
* [Docker](https://github.com/abdulrahmanazab/docker-training-neic/blob/neic-conference-2019/docker.md)
* [Singularity](https://github.com/abdulrahmanazab/docker-training-neic/blob/neic-conference-2019/singularity.md)
* [Docker on HTCondor](https://github.com/abdulrahmanazab/docker-training-neic/blob/neic-conference-2019/docker-htcondor.md)
* [Singularity MPI](https://github.com/abdulrahmanazab/docker-training-neic/blob/neic-conference-2019/singularity-openmpi.md)
