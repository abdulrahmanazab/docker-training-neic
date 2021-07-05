
# Containers Tutorial - PRACE training, 2021

The training infrastructure is offered by 
* [Piz Daint](https://www.cscs.ch/computers/piz-daint/) at CSCS, Switserland.
* [Norwegian Research and Education cloud](https://www.nrec.no/)

Connect to your VM
--------------------
* You will get the key file ``nrec.pem`` from your instructor
* Now use it to connect to your VM:
```bash
chmod 600 nrec.pem 
ssh -i nrec.pem debian@<Terminal-IP-Address>
```
Tutorial contents
------------------
* [Docker](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/docker.md)
* [Singularity](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/singularity.md)
* [SARUS](https://github.com/abdulrahmanazab/docker-training-neic/blob/prace-training-2021/sarus.md)
* [Docker on HTCondor](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/docker-htcondor.md)
* [Singularity MPI](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/singularity-openmpi.md)
* [Singularity GPU support](https://github.com/abdulrahmanazab/docker-training-neic/blob/prace-training-2021/singularity-gpu.md)
* [Unikernels](https://github.com/abdulrahmanazab/docker-training-neic/blob/prace-training-2021/unikernels.md)
