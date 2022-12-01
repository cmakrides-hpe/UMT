# Determine some characteristics of the OpenMP target device (gpu).
# 
# For now, make some assumptions based on the compiler we are using.
# - XL - assume we are on Sierra
# - Cray - assume we are on El Cap
#
# Sets:
# This is the number of 'streaming multiprocessors' or 'compute units'.
# OMP_TARGET_NUM_PROCESSORS
# This is the number of threads supported per thread team/ block on the target device.
# OMP_TARGET_MAX_THREADS_PER_THREAD_TEAM

if (CMAKE_Fortran_COMPILER_ID STREQUAL "XL")
  set(OMP_DEVICE_NUM_PROCESSORS 80)
  set(OMP_DEVICE_TEAM_THREAD_LIMIT 1024)
elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "Cray")
  if( $ENV{CRAY_ACCEL_TARGET} STREQUAL "amd_gfx90a")
    set(OMP_DEVICE_NUM_PROCESSORS 110)
    set(OMP_DEVICE_TEAM_THREAD_LIMIT 1024)
  elseif( $ENV{CRAY_ACCEL_TARGET} STREQUAL "nvidia80")
    set(OMP_DEVICE_NUM_PROCESSORS 108)
    # 512 is the largest value I can set here (for now) that will
    # run on A100 with CCE 15.0.0
    set(OMP_DEVICE_TEAM_THREAD_LIMIT 512)
  endif()
else()
  set(OMP_DEVICE_NUM_PROCESSORS 1)
  set(OMP_DEVICE_TEAM_THREAD_LIMIT 1)
endif()

mark_as_advanced(OMP_DEVICE_NUM_PROCESSORS OMP_DEVICE_TEAM_THREAD_LIMIT)
