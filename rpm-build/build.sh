cd "$(dirname "$0")"

docker run -e BUILD_NUMBER --rm -v `pwd`:`pwd` registry.cn-shanghai.aliyuncs.com/tty/ct:all bash -x `pwd`/build-in-docker.sh



