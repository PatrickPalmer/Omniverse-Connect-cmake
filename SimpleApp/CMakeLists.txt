
cmake_minimum_required(VERSION 3.21)

project(SimpleApp)

FIND_PACKAGE(OmniverseClient REQUIRED)
include_directories(${OmniverseClient_INCLUDE_DIR})

FIND_PACKAGE(NVidiaUSD REQUIRED)
include_directories(${NVidiaUSD_INCLUDE_DIR})


add_executable(${PROJECT_NAME} Main.cpp)


target_link_libraries(${PROJECT_NAME} 
                      ${OmniverseClient_LIBRARIES}
                      ${NVidiaUSD_LIBRARIES})

if(WIN32)
    target_link_libraries(${PROJECT_NAME} wsock32 ws2_32)
endif(WIN32)


if(WIN32)
    # robocopy returns positive numbers for success as well as errors

    add_custom_command(
        TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND cmd /c robocopy /s ${OmniverseClient_LIBRARY_DIR} $<TARGET_FILE_DIR:${PROJECT_NAME}> /NFL /NDL /NJH /NJS /nc /ns /np ^& IF %ERRORLEVEL% LEQ 8 exit 0
    )

    add_custom_command(
        TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND cmd /c robocopy /s ${NVidiaUSD_LIBRARY_DIR} $<TARGET_FILE_DIR:${PROJECT_NAME}> /NFL /NDL /NJH /NJS /nc /ns /np ^& IF %ERRORLEVEL% LEQ 8 exit 0
    )

endif(WIN32)



