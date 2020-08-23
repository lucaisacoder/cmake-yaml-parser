#!/bin/bash

TARGET_MODULE_NAME="cmake-yaml-parser"
TARGET_BUILD_FOLDER=$(pwd)/build
TARGET_INSTALL_FOLDER=$(pwd)/installed

TARGET_RELEASE_FOLDER=$(pwd)/release

TEST_MODULE_NAME="cyp_test"
TEST_BUILD_FOLDER=$(pwd)/test/build

# build
build()
{
    if [ -d ${TARGET_INSTALL_FOLDER} ]; then
        rm -rf ${TARGET_INSTALL_FOLDER}
    fi

    if [ -d ${TARGET_BUILD_FOLDER} ]; then
        rm -rf ${TARGET_BUILD_FOLDER}
    fi
    mkdir ${TARGET_BUILD_FOLDER} && cd ${TARGET_BUILD_FOLDER}

    cmake .. -DCMAKE_INSTALL_PREFIX=${TARGET_INSTALL_FOLDER} -DCMAKE_PREFIX_PATH=${TARGET_INSTALL_FOLDER} && make install

    if [ $? -ne 0 ]; then
        echo "build ${TARGET_MODULE_NAME} FAILED!"
        exit 1
    fi
    echo "build ${TARGET_MODULE_NAME} SUCCESS!"
}

# build
build_test()
{
    if [ -d ${TEST_BUILD_FOLDER} ]; then
        rm -rf ${TEST_BUILD_FOLDER}
    fi
    mkdir ${TEST_BUILD_FOLDER} && cd ${TEST_BUILD_FOLDER}

    cmake .. -DCMAKE_INSTALL_PREFIX=${TARGET_INSTALL_FOLDER} -DCMAKE_PREFIX_PATH=${TARGET_INSTALL_FOLDER}

    if [ $? -ne 0 ]; then
        echo "build ${TEST_MODULE_NAME} FAILED!"
        exit 1
    fi
    echo "build ${TEST_MODULE_NAME} SUCCESS!"
}

# distclean
distclean()
{
    _MODULE_NAME=$1
    _BUILD_FOLDER=$2
    _EXIT_FLAG=$3

    if [ -d ${TARGET_INSTALL_FOLDER} ]; then
        rm -rf ${TARGET_INSTALL_FOLDER}
    fi

    if [ -d ${TARGET_BUILD_FOLDER} ]; then
        rm -rf ${TARGET_BUILD_FOLDER}
    fi

    if [ $? -ne 0 ]; then
        echo "distclean ${TARGET_MODULE_NAME} FAILED!"
        exit 0
    fi
    echo "distclean ${TARGET_MODULE_NAME} SUCCESS!"
    if [[ ${_EXIT_FLAG} -eq 1 ]]; then
        exit 0
    fi
}

# distclean_test
distclean_test()
{

    if [ -d ${TEST_BUILD_FOLDER} ]; then
        rm -rf ${TEST_BUILD_FOLDER}
    fi

    if [ $? -ne 0 ]; then
        echo "distclean ${TEST_MODULE_NAME} FAILED!"
        exit 0
    fi

    echo "distclean ${TEST_MODULE_NAME} SUCCESS!"
}

# dist version version exit_flag
dist()
{
    cd ${TARGET_BUILD_FOLDER}
    cpack

    if [ ! -d ${TARGET_RELEASE_FOLDER} ]; then
        mkdir ${TARGET_RELEASE_FOLDER}
    fi
    cp ./cmake-yaml-parser-*.tar.gz ${TARGET_RELEASE_FOLDER}/
}

# test
test()
{
    distclean
    distclean_test

    build
    build_test

    cd ${TEST_BUILD_FOLDER}

    #make test

    if [[ $? -ne 0 ]]; then
        ret=1
    else
        ret=0
    fi

    if [[ ${ret} -ne 0 ]]; then
        echo "test FAILED!"
        exit 1
    else
        echo "test PASS!"
        dist
    fi

    distclean
    distclean_test

    exit 0
}

ut_test()
{
   _UT_TEST_FOLDER=$(pwd)/cyp_test

    cd ${_UT_TEST_FOLDER}
    echo "$(pwd)"
    ./ut_cyp_python.py

    exit 0
}


while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -b|--build)
    build
    shift
    shift
    ;;
    -d|--distclean)
    distclean
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
    -u|--ut)
    ut_test
    shift
    shift
    ;;
    *)    # unknown option
    shift
    shift
    ;;
esac
done