include(${S3G_MAX_SDK_BASE_DIR}/script/max-pretarget.cmake)

include_directories(
  "${MAX_SDK_INCLUDES}"
  "${MAX_SDK_MSP_INCLUDES}"
  "${MAX_SDK_JIT_INCLUDES}"
)

add_library(${PROJECT_NAME} MODULE s3g_ambigrain_tilde.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE s3g_dsp_headers)

include(${S3G_MAX_SDK_BASE_DIR}/script/max-posttarget.cmake)
