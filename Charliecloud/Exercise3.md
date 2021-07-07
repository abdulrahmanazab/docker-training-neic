# Exercise 3
## QuantEX (Quantum gate simulator) container example
1.	Go to the directory on the HPC system that contains the pico_quant Charliecloud image 
2.	Start a bash shell using the beelow command.
```
$ ch-run --set-env=./pico_quant/ch/environment -w ./pico_quant -- bash
$ julia
$ using Pkg
$ Pkg.add("PicoQuant")
$ Pkg.activate("/PicoQuant")
$ Pkg.test("PicoQuant")
$ exit
```
The variable –set-env allows the user to import and environment stored in the file, rather than using the default environment, which is the same as the host environment.
The reason we need to do this is because Julia installed inside the container recquires the same environment as the Docker image created from the Dockerfile.
