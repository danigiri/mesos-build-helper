# mesos-build-helper
Building Apache Mesos and generating a custom RPM

## Build instructions

### CentOS RPM
```
git clone https://github.com/danigiri/mesos-build-helper.git
cd mesos-build-helper
chmod a+x script/*
IMAGE_NAME=mesos-build-helper ./script/build
```

### Ubuntu RPM
```
git clone https://github.com/danigiri/mesos-build-helper.git
cd mesos-build-helper
chmod a+x script/*
IMAGE_NAME=mesos-build-helper-ubuntu DOCKER_FILE=Dockerfile-ubuntu ./script/build
```

