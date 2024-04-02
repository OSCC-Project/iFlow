#!/bin/bash
###
 # @Author: Zhisheng Zeng
 # @Date: 2021-09-18 15:41:41
 # @Description: 
 # @LastEditors: Zhisheng Zeng
 # @LastEditTime: 2021-09-18 17:54:13
 # @FilePath: /iFlow/scripts/shell/install_tools.sh
### 

source $IFLOW_SHELL_DIR/common.sh

echo "_____ ________________ _______ ___       __"
echo "___(_)___  ____/___  / __  __ \__ |     / /"
echo "__  / __  /_    __  /  _  / / /__ | /| / / "
echo "_  /  _  __/    _  /___/ /_/ / __ |/ |/ /  "
echo "/_/   /_/       /_____/\____/  ____/|__/   "
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
sleep 1

# yosys4be891e8
# CHECK_DIR $IFLOW_TOOLS_DIR/yosys4be891e8 || RUN git clone https://${IFLOW_MIRROR_URL}/The-OpenROAD-Project/yosys.git tools/yosys4be891e8
# RUN cd $IFLOW_TOOLS_DIR/yosys4be891e8
# RUN git checkout 4be891e8
# CHECK_DIR $IFLOW_TOOLS_DIR/yosys4be891e8/build || RUN mkdir build
# RUN cd build 
# RUN make -f ../Makefile -j$IFLOW_BUILD_THREAD_NUM
# RUN cd $IFLOW_ROOT_DIR

# TritonRoute758cdac
# CHECK_DIR $IFLOW_TOOLS_DIR/TritonRoute758cdac || RUN git clone https://${IFLOW_MIRROR_URL}/The-OpenROAD-Project/TritonRoute.git tools/TritonRoute758cdac
# RUN cd $IFLOW_TOOLS_DIR/TritonRoute758cdac
# RUN git checkout 758cdac
# CHECK_DIR $IFLOW_TOOLS_DIR/TritonRoute758cdac/build || RUN mkdir build
# RUN cd build 
# RUN cmake .. 
# RUN make -j$IFLOW_BUILD_THREAD_NUM
# RUN cd $IFLOW_ROOT_DIR

RUN_ROOT apt-get update && apt-get install -y git tcl-dev ninja-build build-essential clang \
    libreadline-dev bison flex libffi-dev cmake libboost-all-dev swig libeigen3-dev libspdlog-dev

OPENROAD110=$IFLOW_TOOLS_DIR/OpenROAD9295a533
OPENROAD120=$IFLOW_TOOLS_DIR/OpenROADae191807

CHECK_DIR $OPENROAD110 || RUN git clone https://${IFLOW_MIRROR_URL}/The-OpenROAD-Project/OpenROAD.git tools/OpenROAD9295a533
CHECK_DIR $OPENROAD120 || RUN cp -r $OPENROAD110 $OPENROAD120

# OpenROAD9295a533
RUN cd $OPENROAD110 
RUN git checkout 9295a533 
RUN cd $OPENROAD110/src
RUN git submodule update --init --recursive --depth=1 OpenSTA OpenDB flute3 replace ioPlacer FastRoute eigen TritonMacroPlace OpenRCX
CHECK_DIR $OPENROAD110/src/PDNSim || RUN git clone https://${IFLOW_MIRROR_URL}/ZhishengZeng/PDNSim.git PDNSim --depth=1 --branch=master

RUN cd $OPENROAD110
RUN mkdir -p build bin
RUN cmake -S$OPENROAD110 -B$OPENROAD110/build -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:FILEPATH=$OPENROAD110/bin -DCMAKE_INSTALL_PREFIX=$OPENROAD110/bin -G Ninja
RUN cmake --build $OPENROAD110/build -j $IFLOW_BUILD_THREAD_NUM
RUN cd $IFLOW_ROOT_DIR

# OpenROADae191807
RUN cd $OPENROAD120 
RUN git checkout ae191807  
RUN git submodule update --init --recursive --depth=1

RUN mkdir -p build bin
RUN cmake -S$OPENROAD120 -B$OPENROAD120/build -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:FILEPATH=$OPENROAD120/bin -DCMAKE_INSTALL_PREFIX=$OPENROAD120/bin -G Ninja
cmake -S$(pwd) -B$(pwd)/build -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:FILEPATH=$(pwd)/bin -DCMAKE_INSTALL_PREFIX=$(pwd)/bin  -G Ninja
RUN cmake --build $OPENROAD120/build -j $IFLOW_BUILD_THREAD_NUM
RUN cd $IFLOW_ROOT_DIR

echo ""
echo "************************************"
echo "[iFlow Info] Checking... "
if (CHECK_DIR $IFLOW_ROOT_DIR/tools/yosys4be891e8) && (CHECK_DIR $IFLOW_ROOT_DIR/tools/OpenROAD9295a533) && (CHECK_DIR $IFLOW_ROOT_DIR/tools/OpenROADae191807); then
    echo "[iFlow Info] Successful! "
else
    echo "[iFlow Info] Failed! "
fi
echo "************************************"
