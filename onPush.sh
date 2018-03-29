BUILDDIR=~/git/ull

touch /tmp/onPushStart
cd $BUILDDIR
sleep 60
git pull
make *.stl
touch /tmp/onPushEnd

