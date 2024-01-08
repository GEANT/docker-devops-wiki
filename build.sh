#!/bin/bash
#
usage() {
    echo "Usage: $(basename $0)"
    echo "    -h | --help      Print this help and exit"
    echo "    -n | --no-cache  Do not use cache when building the image [default: no]"
    echo "    -r | --run       Run the container after build [default: no]"
    echo ""
    exit 2
}

OPTS=$(getopt -o "h,r,n" --longoptions "help,run,no-cache" -- "$@")
eval set -- "$OPTS"

while true; do
    case "$1" in
    -h | --help)
        usage
        ;;
    -n | --no-ceche)
        NO_CACHE="--no-cache"
        ;;
    -r | --run)
        RUN="docker run -it -p 8000:80 -p 8080:8080 devops-wiki"
        ;;
    --)
        shift
        break
        ;;
    esac
    shift
done

docker build $NO_CACHE -f Dockerfile-local -t devops-wiki .
$RUN
