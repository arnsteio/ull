# arnsteio, 2017
# This script starts the build process on the build host
# It is meant to be invoked from git hooks (.git/hooks/)

BUILDDIR=~/git/ull
VER=ull_v4

date > /tmp/onPushStart
cd $BUILDDIR
git pull
# If following line fails no build will start
mv $VER.stl{,-`date +%s`}
# If above line fails this should still work, triggering the build
rm $VER.stl
make $VER.stl
date > /tmp/onPushEnd

