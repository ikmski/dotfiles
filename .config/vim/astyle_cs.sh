#!/bin/bash

#===============================================================================
# Functions
#===============================================================================

function _format()
{
    astyle --options=${OPTION_FILE} --suffix=none ${INPUT_FILE}
}

function _usage()
{
    echo "Usage: ${PROGRAM_NAME} INPUT_FILE"
    echo ""
    exit 1
}

#===============================================================================
# Valiables
#===============================================================================

PROGRAM_NAME=$(basename $0)
VERSION="1.0"

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

OPTION_FILE=${SCRIPT_DIR}/.astyle_cs_options

INPUT_FILE=""

#===============================================================================
# Main
#===============================================================================

type astyle >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Please install astyle!"
    exit 1
fi

if [ ! -e ${OPTION_FILE} ]; then
    echo "${OPTION_FILE} not found"
    exit 1
fi

if [ $# -ne 1 ]; then
  _usage
  exit 1
fi
INPUT_FILE=$1

_format
