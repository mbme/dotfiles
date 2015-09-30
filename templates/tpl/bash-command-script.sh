#!/usr/bin/env bash

PROGRAM="${0##*/}"
VERSION="1.0"

cmd_version() {
    echo "$PROGRAM $VERSION"
}

cmd_usage() {
    cmd_version
    echo
    cat <<-_EOF
	Usage:
	    $PROGRAM help
	        Show this text.
	    $PROGRAM version
	        Show version information.
	_EOF
}

COMMAND="$1"

case "$1" in
    version|--version) shift;   cmd_version "$@" ;;
    help|--help) shift;         cmd_usage "$@" ;;
    *) COMMAND="help";          cmd_usage "$@" ;;
esac
exit 0
