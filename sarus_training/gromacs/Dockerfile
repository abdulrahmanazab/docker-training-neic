FROM nvidia/cuda:11.2.0-devel-centos8

# Enable the PowerTools repository
RUN yum install -y dnf-plugins-core \
    && yum config-manager --set-enabled powertools \
    && yum clean all \
    && rm -rf /var/cache/yum/*

# Install EPEL repositories
RUN yum install -y epel-release \
    && yum clean all \
    && rm -rf /var/cache/yum/*

# Install system packages
RUN yum install -y \
            wget \
            cmake \
            automake \
            autoconf \
            libtool \
            strace \
            cmake \
            python3 \
            zlib-devel \
            libarchive \
            openblas-devel \
    && yum clean all \
    && rm -rf /var/cache/yum/*

# Install MPICH
RUN wget -q http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz \
    && tar xf mpich-3.1.4.tar.gz \
    && cd mpich-3.1.4 \
    && ./configure --disable-fortran --enable-fast=all,O3 --prefix=/usr \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && cd .. \
    && rm -rf mpich-3.1.4 mpich-3.1.4.tar.gz

# Install GROMACS
RUN wget -q http://ftp.gromacs.org/pub/gromacs/gromacs-2020.4.tar.gz \
    && tar xf gromacs-2020.4.tar.gz \
    && cd gromacs-2020.4 \
    && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release  \
             -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
             -DGMX_MPI=on -DGMX_SIMD=AVX2_256 \
             -DGMX_GPU=CUDA \
             .. \
    && make -j$(nproc) \
    && make check -j$(nproc) \
    && make install \
    && cd ../.. \
    && rm -r gromacs-2020.4 gromacs-2020.4.tar.gz

ENV PATH=/usr/local/gromacs/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/gromacs/lib:$PD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=/usr/local/gromacs/lib/pkgconfig:$PKG_CONFIG_PATH
ENV MANPATH=/usr/local/gromacs/share/man/:$MANPATH

