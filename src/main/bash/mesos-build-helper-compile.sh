#!/usr/bin/env bash

#  Copyright 2015 Daniel Giribet <dani - calidos.cat>
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# ______________________________________________________________________________

[ -z "$JAVA_HOME" ] && export JAVA_HOME='/usr/lib/jvm/java'

# Output message on STDERR <message>
echoerr_() { printf %s\\n "$@" 1>&2; }

echoerr_ 'Building Apache Mesos v${mesos.version_} at ${mesos.sourcefolder_}, standby...'

# Avoid annoying perl warnings when bootstrapping mesos
export LC_ALL=C
export LANG=C

echoerr_ 'Bootstrapping... (check ${mesos.sourcefolder_}/bootstrap.output for logs)'
chmod -v a+x bootstrap
./bootstrap > ./bootstrap.output 2>&1
ERR_=$?
if [ $ERR_ -ne 0 ]; then
	echo "Error running bootstrap, check '${mesos.buildfolder_}/bootstrap.output'"
	exit $ERR_
fi
echoerr_ 'Bootstrap complete'

mkdir -vp ${mesos.buildfolder_}
cd ${mesos.buildfolder_}
echoerr_ 'Configuring... (check ${mesos.buildfolder_}/configure.output for logs)'
chmod -v a+x ../configure
../configure > ./configure.output 2>&1

echoerr_ 'Building... (check ${mesos.buildfolder_}/make.output for logs)'
make > ./make.output 2>&1
ERR_=$?
if [ $ERR_ -ne 0 ]; then
	echo "Error running make, check '${mesos.buildfolder_}/make.output'"
	exit $ERR_
fi
echoerr_ 'Configure complete'

echoerr_ 'Installing temporarily... (check ${mesos.buildfolder_}/install.output for logs)'
export DESTDIR=${mesos.destdir_}
make install > ./install.output 2>&1
ERR_=$?
if [ $ERR_ -ne 0 ]; then
	echo "Error running make install, check '${mesos.buildfolder_}/install.output'"
	exit $ERR_
fi
echoerr_ 'Make install complete'
