
# Containers workshop material NeIC AHM 2018

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
* [Docker](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2018/docker.md)
* [Docker on HTCondor](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2018/docker-htcondor.md)
* [Singularity **(Extra)**](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2018/singularity.md)
