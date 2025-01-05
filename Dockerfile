# From https://x.com/amannijhawan/status/1875026931265253772 by https://x.com/amannijhawan

FROM ubuntu:latest

RUN apt update
RUN apt upgrade -y
# install cmake per https://askubuntu.com/questions/610291/how-to-install-cmake-3-2-on-ubuntu --AN
RUN apt-get install -y software-properties-common  
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x
RUN apt-get install -y cmake
# end install cmake
RUN apt install -y autoconf build-essential ccache curl file g++ gcc gettext git golang libffi-dev locales maven ninja-build npm patchelf pkg-config python3 python3-dev python3-venv rsync

# Somehow, the repo contains files with names longer than 255 characters.
# I bypassed this locally with a virtual filesystem.
# The build problem is the same though, so I assume it's OK to just ignore those files for this Dockerfile-based test.
RUN git clone https://github.com/yugabyte/yugabyte-db && echo OK || echo "Long file names, but sigh, proceeding."
# Add Locale as it is needed to run UT --- AN
RUN apt-get install -y locales-all
# end add locale
RUN (cd yugabyte-db; ./yb_build.sh release)
