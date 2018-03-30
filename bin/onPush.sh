# arnsteio, 2017
# This script starts the build process on the build host
# It is meant to be invoked from git hooks (.git/hooks/)

BUILDDIR=~/git/ull

touch /tmp/onPushStart
cd $BUILDDIR
git pull
make *.stl
touch /tmp/onPushEnd

