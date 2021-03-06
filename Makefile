#
# Makefile for gcc-arm-none-linux-gnueabihf project
# 
# Copyright (C) 2021 Christos Choutouridis <hoo2@hoo2.net>
#
# This program is distributed under the MIT licence
# You should have received a copy of the MIT licence along with this program.
# If not, see <https://www.mit.edu/~amini/LICENSE.md>.

DOCKER     	    := docker
TARGET     	    := hoo2/gcc-arm-none-linux-gnueabihf

WEB_VERSION	    := 9.2-2019.12
VERSION_MAJ     := 9
VERSION_MIN     := 2
VERSION_PATCH   := 1

build:
	$(DOCKER) build --build-arg VERSION=$(WEB_VERSION) -t $(TARGET):$(WEB_VERSION) .
	$(DOCKER) image tag $(TARGET):$(WEB_VERSION) $(TARGET):latest
	$(DOCKER) image tag $(TARGET):$(WEB_VERSION) $(TARGET):$(VERSION_MAJ).$(VERSION_MIN).$(VERSION_PATCH)
	$(DOCKER) image tag $(TARGET):$(WEB_VERSION) $(TARGET):$(VERSION_MAJ).$(VERSION_MIN)
	$(DOCKER) image tag $(TARGET):$(WEB_VERSION) $(TARGET):$(VERSION_MAJ)

.PHONY: push
push:
	$(DOCKER) push -a $(TARGET)

.PHONY: all
all: build push