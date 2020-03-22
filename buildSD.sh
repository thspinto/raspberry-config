#!/bin/bash
OS_ZIP=~/Downloads/raspbian.zip

set -e

help() {
  echo "Usage:"
  echo "    $1 -h                                        Display this help message."
  echo "    $1 <disk path> [-f OS img zip path]          Install OS to path"
  echo
}

echoerr() { echo "$@" 1>&2; }

check_paths() {
  if [[ ! -f $OS_ZIP ]]
  then
      echoerr "file $OS_ZIP not found"
      exit 1
  fi

  if [[ ! -b $DISK_PATH ]]
  then
      echoerr "disk $DISK_PATH doesn't exist"
      exit 1
  fi
}

main() {
  check_paths
  echo "Installing $OS_ZIP to $DISK_PATH"

  # Only supporting OSX for now
  sudo diskutil unmountDisk $DISK_PATH
  unzip -p $OS_ZIP | sudo dd of=$DISK_PATH bs=4m
  sudo diskutil mount $DISK_PATH
  touch /Volumes/boot/ssh
}

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      help
      exit 0
      ;;
    -z|--zip)
      OS_ZIP=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      help
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"
DISK_PATH=$1

main
