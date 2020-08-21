#!/bin/bash

TARGET_MODULE_NAME="cmake-yaml-parser"
TARGET_BUILD_FOLDER=$(pwd)/build
TARGET_INSTALL_FOLDER=$(pwd)/installed

# build module_name build_folder exit_flag
build()
{
    _MODULE_NAME=$1
    _BUILD_FOLDER=$2
    _EXIT_FLAG=$3

    if [ -d ${TARGET_INSTALL_FOLDER} ]; then
        rm -rf ${TARGET_INSTALL_FOLDER}
    fi

    if [ -d ${_BUILD_FOLDER} ]; then
        rm -rf ${_BUILD_FOLDER}
    fi
    mkdir ${_BUILD_FOLDER} && cd ${_BUILD_FOLDER}

    cmake .. -DCMAKE_INSTALL_PREFIX=${TARGET_INSTALL_FOLDER} -DCMAKE_PREFIX_PATH=${TARGET_INSTALL_FOLDER} && make install

    if [ $? -ne 0 ]; then
        echo "build ${_MODULE_NAME} FAILED!"
        exit 1
    fi
    echo "build ${_MODULE_NAME} SUCCESS!"

    if [[ ${_EXIT_FLAG} -eq 1 ]]; then
        exit 0
    fi
}

# build module_name build_folder exit_flag
build_test()
{
    _MODULE_NAME=$1
    _BUILD_FOLDER=$2
    _EXIT_FLAG=$3

    if [ -d ${_BUILD_FOLDER} ]; then
        rm -rf ${_BUILD_FOLDER}
    fi
    mkdir ${_BUILD_FOLDER} && cd ${_BUILD_FOLDER}

    cmake .. -DCMAKE_INSTALL_PREFIX=${TARGET_INSTALL_FOLDER} -DCMAKE_PREFIX_PATH=${TARGET_INSTALL_FOLDER}

    if [ $? -ne 0 ]; then
        echo "build ${_MODULE_NAME} FAILED!"
        exit 1
    fi
    echo "build ${_MODULE_NAME} SUCCESS!"

    if [[ ${_EXIT_FLAG} -eq 1 ]]; then
        exit 0
    fi
}

# build module_name build_folder exit_flag
clean()
{
    _MODULE_NAME=$1
    _BUILD_FOLDER=$2
    _EXIT_FLAG=$3

    if [ ! -d ${_BUILD_FOLDER} ]; then
        echo "YOU NEED RUN './run.sh --build' FIRST"
        return 0
    fi
    cd ${_BUILD_FOLDER}

    make clean

    if [ $? -ne 0 ]; then
        echo "clean ${_MODULE_NAME} FAILED!"
        exit 1
    fi
    echo "clean ${_MODULE_NAME} SUCCESS!"

    if [[ ${_EXIT_FLAG} -eq 1 ]]; then
        exit 0
    fi
}

# rebuild module_name build_folder
rebuild()
{
    _MODULE_NAME=$1
    _BUILD_FOLDER=$2

    clean ${_MODULE_NAME} ${_BUILD_FOLDER}
    build ${_MODULE_NAME} ${_BUILD_FOLDER}

    exit 0
}

# distclean module_name build_folder exit_flag
distclean()
{
    _MODULE_NAME=$1
    _BUILD_FOLDER=$2
    _EXIT_FLAG=$3

    if [ -d ${TARGET_INSTALL_FOLDER} ]; then
        rm -rf ${TARGET_INSTALL_FOLDER}
    fi

    if [ -d ${_BUILD_FOLDER} ]; then
        rm -rf ${_BUILD_FOLDER}
    fi

    if [ $? -ne 0 ]; then
        echo "distclean ${_MODULE_NAME} FAILED!"
        exit 0
    fi
    echo "distclean ${_MODULE_NAME} SUCCESS!"
    if [[ ${_EXIT_FLAG} -eq 1 ]]; then
        exit 0
    fi
}

# test
test()
{
    TEST_MODULE_NAME="cyp-test"
    TEST_BUILD_FOLDER=$(pwd)/test/build

    distclean ${TEST_MODULE_NAME} ${TEST_BUILD_FOLDER}
    distclean ${TARGET_MODULE_NAME} ${TARGET_BUILD_FOLDER}

    build ${TARGET_MODULE_NAME} ${TARGET_BUILD_FOLDER}
    build_test ${TEST_MODULE_NAME} ${TEST_BUILD_FOLDER}

    #cd ${TEST_BUILD_FOLDER}

    make test

    if [[ $? -ne 0 ]]; then
        ret=1
    else
        ret=0
    fi

    distclean ${TEST_MODULE_NAME} ${TEST_BUILD_FOLDER}
    distclean ${TARGET_MODULE_NAME} ${TARGET_BUILD_FOLDER}

    if [[ ${ret} -ne 0 ]]; then
        echo "test FAILED!"
        exit 1
    else
        echo "test PASS!"
        exit 0
    fi
}

# dist version version exit_flag
dist()
{
    _VERSION = $1
    _EXIT_FLAG=$3

    #make pack

    if [[ ${_EXIT_FLAG} -eq 1 ]]; then
        exit 0
    fi
}


while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -b|--build)
    build ${TARGET_MODULE_NAME} ${TARGET_BUILD_FOLDER} 1
    shift
    shift
    ;;
    -r|--rebuild)
    rebuild ${TARGET_MODULE_NAME} ${TARGET_BUILD_FOLDER}
    shift
    shift
    ;;
    -c|--clean)
    clean ${TARGET_MODULE_NAME} ${TARGET_BUILD_FOLDER} 1
    shift
    shift
    ;;
    -d|--distclean)
    distclean ${TARGET_MODULE_NAME} ${TARGET_BUILD_FOLDER} 1
    shift
    shift
    ;;
    -t|--test)
    test
    shift
    shift
    ;;
    --dist)
    dist
    shift
    shift
    ;;
    *)    # unknown option
    shift
    shift
    ;;
esac
done