
# Containers Tutorial - NORBIS 2022

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
* [Docker](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-2022/docker.md)
* [Singularity](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-2022/singularity.md)
* [Docker on HTCondor](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-2022/docker-htcondor.md)
* [Singularity MPI](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-2022/singularity-openmpi.md)
* [Unikernels](https://github.com/abdulrahmanazab/docker-training-neic/blob/norbis-2022/unikernels.md)
