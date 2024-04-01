#!/bin/bash
# ***************************************************************************************
# Copyright (c) 2023-2025 Beijing Institute of Open Source Chip
# Copyright (c) 2023-2025 Institute of Computing Technology, Chinese Academy of Sciences
# Copyright (c) 2023-2025 Peng Cheng Laboratory
#
# iFlow is licensed under Mulan PSL v2.
# You can use this software according to the terms and conditions of the Mulan PSL v2.
# You may obtain a copy of Mulan PSL v2 at:
# http://license.coscl.org.cn/MulanPSL2
#
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
#
# See the Mulan PSL v2 for more details.
# ***************************************************************************************
# env
IFLOW_BUILD_THREAD_NUM=$(cat /proc/cpuinfo | grep "processor" | wc -l)
IFLOW_ROOT_DIR=$(cd "$(dirname "$0")" && pwd)
IFLOW_SHELL_DIR=$(cd "$(dirname "$0")" && pwd)/scripts/shell
IFLOW_TOOLS_DIR=$(cd "$(dirname "$0")" && pwd)/tools

if [ $# == "0" ];then
    IFLOW_MIRROR_URL="github.com"
elif [ $# == "2" ] && [ $1 == "-mirror" ];then
    IFLOW_MIRROR_URL=$2
else
    echo "please use './build_flow.sh -mirror <mirror url>' !"
    exit
fi

export IFLOW_BUILD_THREAD_NUM
export IFLOW_ROOT_DIR
export IFLOW_SHELL_DIR
export IFLOW_TOOLS_DIR
export IFLOW_MIRROR_URL
export DEBIAN_FRONTEND=noninteractive

source $IFLOW_SHELL_DIR/common.sh

# essential package
RUN_ROOT apt-get update && apt-get install -y git wget build-essential clang libreadline-dev \
    bison flex libffi-dev cmake libboost-all-dev swig klayout libeigen3-dev libspdlog-dev tcl-dev
RUN_ROOT cp -f /usr/include/tcl8.6/*.h /usr/include/
RUN_ROOT ln -s -f /usr/lib/x86_64-linux-gnu/libtcl8.6.so /usr/lib/x86_64-linux-gnu/libtcl8.5.so

# lemon
CHECK_DIR /usr/local/include/lemon ||\
{
        RUN wget http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz
        RUN tar zxvf lemon-1.3.1.tar.gz
        RUN cd lemon-1.3.1
        CHECK_DIR build || RUN mkdir build
        RUN cd build
        RUN cmake ..
        RUN make -j$IFLOW_BUILD_THREAD_NUM
        RUN_ROOT make install
        RUN cd ../../
        RUN rm -rf lemon-1.3.1 lemon-1.3.1.tar.gz
}

# install tools
RUN $IFLOW_SHELL_DIR/install_tools.sh

# link iEDA lib
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:'$IFLOW_TOOLS_DIR'/iEDA_0.1/lib' >> ~/.bashrc