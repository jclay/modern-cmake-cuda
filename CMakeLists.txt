cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

project(cmake_cuda LANGUAGES CUDA)

add_executable(cmake_cuda knn.cu)
set_target_properties(cmake_cuda PROPERTIES CUDA_SEPARABLE_COMPILATION ON)