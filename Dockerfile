#
# Dockerfile for gcc-arm-none-linux-gnueabihf image
# 
# Copyright (C) 2021 Christos Choutouridis <hoo2@hoo2.net>
#
# This program is distributed under the MIT licence
# You should have received a copy of the MIT licence along with this program.
# If not, see <https://www.mit.edu/~amini/LICENSE.md>.
#
# versions: 
# ---------
#  release: 9.2-2019.12
#    alias: 9.2.1, 9.2, 9


FROM ubuntu:18.04

ARG VERSION
ENV GCC_INSTALL_PATH    /usr/local
ENV GCC_VERSION         9.2.1

RUN apt-get update                           && \
    apt-get upgrade -y                       && \
    apt-get install --no-install-recommends -y  \
        build-essential                         \
        git                                     \
        bzip2 xz-utils                          \
        wget                                    \
        ca-certificates                      && \
    apt-get clean                            && \
    rm -rf /var/lib/apt/lists/*              && \
    mkdir -p ${GCC_INSTALL_PATH}

# TODO:
# Add link and the inner compressed directory for every release
ENV LINK_9_2_2019_12 \
https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz?revision=fed31ee5-2ed7-40c8-9e0e-474299a3c4ac&hash=C54244E4E3875AACABA1DFB301ACA805

# TODO:
# Add a case for every release
RUN echo "Install version: ${VERSION}" &&   \
    case "${VERSION}" in                    \
    "9.2-2019.12")                          \
        wget -c ${LINK_9_2_2019_12} -O -| tar --xz -x -C ${GCC_INSTALL_PATH}     ;; \
    *)                                      \
        false || echo "Non supported version passed!"  ;;                           \
    esac

ENV PATH    ${GCC_INSTALL_PATH}/gcc-arm-${VERSION}-x86_64-arm-none-linux-gnueabihf/bin:${PATH}

# Start bash login shell
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash", "-i"]