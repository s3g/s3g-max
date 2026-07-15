cmake_minimum_required(VERSION 3.25)

set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "macOS architectures")

include(FetchContent)

set(S3G_DSP_DIR "${CMAKE_CURRENT_LIST_DIR}/../s3g-dsp" CACHE PATH "Path to the sibling s3g-dsp repository")
set(S3G_MAX_SDK_GIT_REPOSITORY "https://github.com/Cycling74/max-sdk-base.git" CACHE STRING "Max SDK base repository")
set(S3G_MAX_SDK_GIT_TAG "main" CACHE STRING "Max SDK base git tag or commit")

if(NOT EXISTS "${S3G_DSP_DIR}/dsp/s3g_layout_panner.h")
  message(FATAL_ERROR "S3G_DSP_DIR must point at the sibling s3g-dsp repo containing dsp/s3g_layout_panner.h")
endif()

FetchContent_Declare(
  max-sdk-base
  GIT_REPOSITORY ${S3G_MAX_SDK_GIT_REPOSITORY}
  GIT_TAG ${S3G_MAX_SDK_GIT_TAG}
)
FetchContent_MakeAvailable(max-sdk-base)
set(S3G_MAX_SDK_BASE_DIR "${max-sdk-base_SOURCE_DIR}" CACHE INTERNAL "Fetched Max SDK base path")

project(s3g_max VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(C74_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/package/externals" CACHE PATH "Max external output directory")

add_library(s3g_dsp_headers INTERFACE)
target_include_directories(s3g_dsp_headers INTERFACE "${S3G_DSP_DIR}/dsp")

add_subdirectory(source/externals/s3g.layoutpan~)
add_subdirectory(source/externals/s3g.dbappan~)
add_subdirectory(source/externals/s3g.lbappan~)
add_subdirectory(source/externals/s3g.vbappan~)
add_subdirectory(source/externals/s3g.subxover~)
add_subdirectory(source/externals/s3g.ambidecoder~)
add_subdirectory(source/externals/s3g.ambisubdecoder~)
add_subdirectory(source/externals/s3g.arrayhpf~)
add_subdirectory(source/externals/s3g.arraydelay~)
add_subdirectory(source/externals/s3g.arraytrim~)
add_subdirectory(source/externals/s3g.ambigrain~)
