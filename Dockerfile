# syntax=docker/dockerfile:1
ARG BASE_IMAGE=ubuntu:20.04
FROM ${BASE_IMAGE}
LABEL maintainer="https://hub.docker.com/u/iedaopensource"

ARG IFLOW_WORKSPACE=/opt/iFlow
ENV PATH=${iEDA_BINARY_DIR}:${PATH}
ENV TZ=Asia/Hong_Kong

ADD https://gitee.com/oscc-project/iFlow.git ${IFLOW_WORKSPACE} 

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

WORKDIR ${IFLOW_WORKSPACE}

RUN bash ${IFLOW_WORKSPACE}/build_iflow.sh && \
    rm -rf $(find .  -name "build" -o -name "test" -o -name ".git")
