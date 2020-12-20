# cd to script dir
cd "$(dirname "$0")"

make

#prepare file for rpm
cp -f _output/qb /usr/bin/

#
JNO=${BUILD_NUMBER-"0"}
s=$(date '+%s')
git_ver=$(git rev-parse --short HEAD)

rel="${JNO}_${s}_${git_ver}"

rpmbuild -bb qb.spec --define "rel $rel"

#
cp /root/rpmbuild/RPMS/x86_64/*.rpm _output
