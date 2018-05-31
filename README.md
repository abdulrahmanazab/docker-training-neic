
# Containers Tutorial PRACEdays 2018

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
[How to use pem file with putty on windows](https://www.youtube.com/watch?v=3h3TuJq0Rx4)

Tutorial contents
------------------
* [Docker](https://github.com/abdulrahmanazab/docker-training-neic/blob/pracedays2018/docker.md)
* [Singularity basics](https://github.com/abdulrahmanazab/docker-training-neic/blob/pracedays2018/singularity.md)
* [Singularity with Open MPI](https://github.com/abdulrahmanazab/docker-training-neic/blob/pracedays2018/singularity-openmpi.md)

Extra (if we have time):
* [Docker on HTCondor](https://github.com/abdulrahmanazab/docker-training-neic/blob/pracedays2018/docker-htcondor.md)

