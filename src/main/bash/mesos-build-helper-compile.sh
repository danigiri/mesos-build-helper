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
# Output message on STDERR <message>
echoerr_() { printf %s\\n "\t$@" 1>&2; }


echoerr_ 'Building Apache Mesos v${mesos.version_}, standby...'
mkdir -vp ${mesos.tempfolder_}
exit 0

echoerr_ 'Bootstrapping... (check ${mesos.tempfolder_}/bootstrap.output for logs)'
./bootstrap > ./bootstrap.output
ERR_=$?
if [ $ERR_ -ne 0 ]; then
	echo "Error running bootstrap, check '${mesos.tempfolder_}/bootstrap.output'"
	exit $ERR_
fi
echoerr_ 'bootstrap complete'

echoerr_ 'Building... (check ${mesos.tempfolder_}/make.output for logs)'
./make > ./make.output
ERR_=$?
if [ $ERR_ -ne 0 ]; then
	echo "Error running make, check '${mesos.tempfolder_}/make.output'"
	exit $ERR_
fi

