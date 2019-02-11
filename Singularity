Bootstrap: docker
From: ubuntu:16.04

%runscript
    /usr/bin/a.out

%environment
    export LD_LIBRARY_PATH=/usr/local/openmpi/lib:/usr/local/lib64:/usr/local/lib:/usr/local/boost/lib:/opt/intel/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/opt/intel//compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:/opt/intel//compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:/opt/intel//compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:/opt/intel/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.7:/opt/intel/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:/usr/local/lib:/usr/local/bagel/lib:$LD_LIBRARY_PATH
    export PATH=/usr/local/bagel/bin:$PATH

%labels
    AUTHOR shiozaki.toru@gmail.com

%post
    apt-get -y update
    apt-get -y install gcc
    apt-get -y install g++
    apt-get -y install wget
    apt-get -y install apt-transport-https
    mkdir temp
    cd temp
    echo "Installing Intel MPI/MKL."
    wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
    apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
    sh -c 'echo deb https://apt.repos.intel.com/mpi all main > /etc/apt/sources.list.d/intel-mpi.list'
    apt-get -y update
    apt-get -y install intel-mpi-2019.2-057
    echo "#include<iostream>\n #include \"mpi.h\"\n int main() { MPI_Init(0, 0); std::cout << \"hello world\" << std::endl; MPI_Finalize(); return 0; }" >> main.cc
    export LD_LIBRARY_PATH=/usr/local/openmpi/lib:/usr/local/lib64:/usr/local/lib:/usr/local/boost/lib:/opt/intel/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/opt/intel//compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:/opt/intel//compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:/opt/intel//compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:/opt/intel/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.7:/opt/intel/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:/usr/local/lib:/usr/local/bagel/lib:$LD_LIBRARY_PATH
    /opt/intel/impi/2019.2.187/intel64/bin/mpicxx -I/opt/intel/impi/2019.2.187/intel64/include main.cc
    cp a.out /usr/bin/
    cd ../
    rm -rf ./temp
    rm -rf /opt/intel