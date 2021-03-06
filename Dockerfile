#  Copyright 2015 Daniel Giribet <dani - calidos.cat>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# docker build -t mesos-build-helper -f Dockerfile .
# docker run -ti --entrypoint /bin/bash mesos-build-helper 

FROM centos:centos7
MAINTAINER Daniel Giribet
ARG mesos_ver=0.28.2
ENV MESOS_VER $mesos_ver
RUN mkdir build
ADD pom.xml LICENSE build/
ADD script build/script
ADD src build/src
WORKDIR build
RUN source ./script/bootstrap
RUN source ./script/setup
