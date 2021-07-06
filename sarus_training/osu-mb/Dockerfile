FROM nvidia/cuda:11.3.0-devel-centos8

RUN yum install -y file \
                   gcc \
                   gcc-c++ \
                   gcc-gfortran \
                   make \
                   gdb \
                   strace \
                   wget \
    && yum clean all \
    && rm -rf /var/cache/yum/*

# Install MPICH
RUN wget -q http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz \
    && tar xf mpich-3.1.4.tar.gz \
    && cd mpich-3.1.4 \
    && ./configure --disable-fortran --enable-fast=all,O3 --prefix=/usr \
    && make -j$(nproc) \
    && make install \
    && ldconfig

# Install OSU Micro-benchmarks
RUN wget -q http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.7.tar.gz \
    && tar xf osu-micro-benchmarks-5.7.tar.gz \
    && cd osu-micro-benchmarks-5.7 \
    && ./configure --prefix=/usr/local CC=$(which mpicc) CFLAGS=-O3 \
                   --enable-cuda --with-cuda-include=/usr/local/cuda/include \
                   --with-cuda-libpath=/usr/local/cuda/lib64 \
    && make \
    && make install \
    && cd .. \
    && rm -rf osu-micro-benchmarks-5.7 \
    && rm osu-micro-benchmarks-5.7.tar.gz

# Add the location of the get_local_rank utility to PATH
ENV PATH=/usr/local/libexec/osu-micro-benchmarks:$PATH

WORKDIR /usr/local/libexec/osu-micro-benchmarks/mpi/pt2pt
