# arnsteio, 2017
# This script starts the build process on the build host
# It is meant to be invoked from git hooks (.git/hooks/)

BUILDDIR=~/git/ull
VER=ull_v4

touch /tmp/onPushStart
cd $BUILDDIR
git pull
rm $VER.stl
make $VER.stl
touch /tmp/onPushEnd

