#!/bin/sh -x

module load PrgEnv-cray
# bring the CCE nightly into your environment
module use /cray/css/compiler/builds/modulefiles/
module load cce/master.nightly-debug
# I want my cray-mpich back, consarnet
module use /opt/cray/pe/lmod/modulefiles/comnet/crayclang/14.0/ofi/1.0/
module load cray-mpich/8.1.21
module load craype-x86-trento

# Create workspace for building umt and required libraries conduit, metis, hypre, mfem.
INSTALL_PATH=/cray/css/perfeng/sabbott/UMT_TPL/cce-16.0.0
mkdir -p ${INSTALL_PATH}
echo Libraries will be installed to: ${INSTALL_PATH}

mkdir -p umt_workspace_cce16
cd umt_workspace_cce16

# Download and build conduit
wget https://github.com/LLNL/conduit/releases/download/v0.8.2/conduit-v0.8.2-src-with-blt.tar.gz
tar xvzf conduit-v0.8.2-src-with-blt.tar.gz
mkdir build_conduit
cd build_conduit
cmake ${PWD}/../conduit-v0.8.2/src -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} -DCMAKE_C_COMPILER=cc -DCMAKE_CXX_COMPILER=CC -DCMAKE_Fortran_COMPILER=ftn -DCMAKE_Fortran_FLAGS="-ef" -DBUILD_SHARED_LIBS=OFF -DENABLE_TESTS=OFF -DENABLE_EXAMPLES=OFF -DENABLE_DOCS=OFF -DENABLE_FORTRAN=ON -DENABLE_MPI=ON -DENABLE_PYTHON=OFF
gmake -j install
cd ..

# Download and build METIS
wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz
tar xvzf metis-5.1.0.tar.gz
cd metis-5.1.0
cmake . -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} -DCMAKE_C_COMPILER=cc -DCMAKE_CXX_COMPILER=CC -DGKLIB_PATH=${PWD}/GKlib
gmake -j install
cd ..

# Download and build HYPRE
wget https://github.com/hypre-space/hypre/archive/refs/tags/v2.24.0.tar.gz
tar xvzf v2.24.0.tar.gz
mkdir build_hypre
cd build_hypre
cmake ${PWD}/../hypre-2.24.0/src -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} -DCMAKE_C_COMPILER=cc
gmake -j install
cd ..

# Download and build MFEM
wget https://github.com/mfem/mfem/archive/refs/tags/v4.4.zip
unzip v4.4.zip
mkdir build_mfem
cd build_mfem
cmake ${PWD}/../mfem-4.4 -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} -DCMAKE_C_COMPILER=cc -DCMAKE_CXX_COMPILER=CC -DMFEM_USE_MPI=TRUE -DMFEM_USE_CONDUIT=TRUE -DMFEM_USE_METIS_5=TRUE -DCMAKE_PREFIX_PATH=${INSTALL_PATH}
# -DCONDUIT_ROOT=${INSTALL_PATH} -DMETIS_ROOT=${INSTALL_PATH} -DHYPRE_ROOT=${INSTALL_PATH}
gmake -j install
echo "If this just failed, then you need to add -fno-cray and continute compilation"
cd ..
