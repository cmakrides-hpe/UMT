# This is an example CMake configuration cache file for UMT.

# It expects that you have required 3rd party libraries for UMT installed in a directory structure like:
# $TPL_ROOT/ library_name / version
# Set TPL_ROOT to where your libraries are installed.

set(TPL_ROOT "/cray/css/perfeng/sabbott/UMT_TPL/cce-15.0.0-conduit-dev" CACHE PATH "")
set(MPI_C_COMPILER  "cc" CACHE PATH "")
set(MPI_CXX_COMPILER  "CC" CACHE PATH "")
set(MPI_Fortran_COMPILER "ftn" CACHE PATH "")

set(CMAKE_CXX_FLAGS "-std=c++11 -Wall" CACHE PATH "")
set(CMAKE_Fortran_FLAGS "-ef -DCRAY_ACC_WAR" CACHE PATH "")

set(CMAKE_Fortran_FLAGS_RELEASE "-O3" CACHE PATH "")
set(CMAKE_Fortran_FLAGS_RELWITHDEBINFO "-O3 -G2" CACHE PATH "")
set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g" CACHE PATH "")

set(CMAKE_CXX_FLAGS_RELEASE "-O3" CACHE PATH "")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -g" CACHE PATH "")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g" CACHE PATH "")

set(TETON_OpenMP_Fortran_FLAGS_RELEASE "-fopenmp -hacc" CACHE STRING "")
set(TETON_OpenMP_Fortran_FLAGS_DEBUG "-fopenmp -hacc" CACHE STRING "")
set(TETON_OpenMP_CXX_FLAGS_RELEASE "-fopenmp" CACHE STRING "")
set(TETON_OpenMP_CXX_FLAGS_DEBUG "-fopenmp" CACHE STRING "")

set(ENABLE_OPENMP ON CACHE BOOL "")
set(ENABLE_OPENMP_OFFLOAD ON CACHE BOOL "")
set(ENABLE_CUDA OFF CACHE BOOL "")
set(ENABLE_CALIPER OFF CACHE BOOL "")
set(ENABLE_MEMUSAGES OFF CACHE BOOL "")
set(ENABLE_MFEM ON CACHE BOOL "")
set(ENABLE_TESTS ON CACHE BOOL "")
set(ENABLE_UMPIRE OFF CACHE BOOL "")
set(ENABLE_SILO OFF CACHE BOOL "")
set(ENABLE_PHYSICSUTILS OFF CACHE BOOL "")
set(ENABLE_ADIAK OFF CACHE BOOL "")

# These libraries are required compile time dependencies
set(SILO_ROOT ${TPL_ROOT} CACHE PATH "")
set(CONDUIT_ROOT ${TPL_ROOT} CACHE PATH "")

# These libraries are link time dependencies.
set(MFEM_ROOT ${TPL_ROOT} CACHE PATH "")
set(HDF5_ROOT ${CRAY_HDF5_DIR} CACHE PATH "")
#set(SZ_ROOT ${TPL_ROOT}/bzip2-1.0.6 CACHE PATH "")
#set(Z_ROOT ${TPL_ROOT}/zlib-1.2.11 CACHE PATH "")
set(HYPRE_ROOT ${TPL_ROOT} CACHE PATH "")
set(METIS_ROOT ${TPL_ROOT} CACHE PATH "")
#set(UMPIRE_ROOT ${TPL_ROOT}/Umpire-6.0.0 CACHE PATH "")


# these are needed by the Cray Fortran compiler
set(STRICT_FPP_MODE ON CACHE BOOL "")
set(OPENMP_HAS_FORTRAN_INTERFACE ON CACHE BOOL "")
set(OPENMP_HAS_USE_DEVICE_ADDR ON CACHE BOOL "")