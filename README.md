
# Containers Tutorial - HPC/NIRD course, 2021

The training infrastructure is offered by the [Norwegian Research and Education Cloud (NREC)](https://www.nrec.no/).

Connect to your VM
--------------------
* You will get the key file ``nrec.pem`` from your instructor
* Now use it to connect to your VM:
```bash
chmod 600 nrec.pem 
ssh -i nrec.pem centos@<Terminal-IP-Address>
[centos@container-tutorial-[1-35] ~]$ 
```
Tutorial contents
------------------
* [Docker](https://github.com/abdulrahmanazab/docker-training-neic/blob/docker.md)
* [Singularity](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/singularity.md)
* [Docker on HTCondor](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/docker-htcondor.md)
* [Singularity MPI](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/singularity-openmpi.md)
