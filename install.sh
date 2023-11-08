#!/bin/sh

set -e

# Defaults, you can edit that variables as you want.
[ -z "${PREFIX}" ] && export PREFIX "/usr"
export BINDIR="${PREFIX}/bin"
export SRCDIR="${PREFIX}/"

mkdir -p ""
