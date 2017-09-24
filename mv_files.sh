#!/bin/bash

function helpMen {
  printf "File Linker v0.1\n\n"
  printf "This script moves a specified files to a specified directory and the creates a symlink in the previous location.\n\n"
  printf "mv_files [OPTION] SOURCE\n\n"
  echo "Options:"
  echo "-h, --help : Displays this message"
  echo "-s, --source : The source path"
  echo "-d, --dest : The destination path"
}

function movLink {
  x="$src"
  y=${x%.bar}
  file=${y##*/}
  echo "-- $source is moved to $dest $(mv $src $dest)"
  echo "-- $dest/$source is liked to $source $(ln -s $dest/$file $src)"
}

OPTIONS=$(getopt -o hs:d: -l help,src:,dest: -- "$@")

if [[ -z $1 ]]; then
  helpMen
  exit
fi

if [ $? -ne 0 ]; then
  echo "getopt error"
  exit 1
fi

eval set -- $OPTIONS

while true; do
  case "$1" in
    -h|--help) helpMen ;;
    -s|--source) src="$2" ; shift ;;
    -d|--dest) dest="$2" ; shift ;;
    --)        shift ; break ;;
    *)         echo "unknown option: $1" ; exit 1 ;;
  esac
  shift
done


if [ $# -ne 0 ]; then
  echo "unknown option(s): $@"
  exit 1
fi

movLink

#file=$1bar
#dest=$2

#if [[ -z $1 ]]; then
#  echo "ERROR: please provide a file name as arg1"
#  exit
#fi

#if [[ -z $2 ]]; then
#  echo "DEBUG: the preset path is used"
#  dest="~/documents/config-x230"
#fi

#echo $(mv $file $dest)
#echo $(ln -s $dest/$file )
