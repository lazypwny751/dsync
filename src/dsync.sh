#!/bin/bash

set -e

export status="true" DO="help" RULES=".rules.sh" CWD="${PWD}"

for _chk_ in "discord.sh" "mkdir" "sha256sum" ; do
	if ! command -v "${_chk_}" &> /dev/null ; then
		echo "Command not found: \"${_chk_}\"."
		export status="false"
	fi
done

if ! "${status}" ; then
	exit 1
fi

while [[ "${#}" -gt 0 ]] ; do
	case "${1}" in
		("--"[sS][yY][nN][cC][hH][rR][oO][nN][iI][zZ][eE]|"--"[sS][yY][nN][cC])
			shift
			export DO="sync"
		;;
		("--"[cC][oO][nN][fF][iI][gG])
			shift
			if [[ -f "${1}" ]] ; then
				export RULES="${1}"
				shift
			fi
		;;
		(*)
			shift # Null opt
		;;
	esac
done

case "${DO}" in
	("sync")
		if [[ -f "${RULES}" ]] ; then
			if [[ ! -d ".git" ]] && [[ ! -f ".gitignore" ]] ; then
				if [[ -d ".dsync" ]] ; then
					mkdir -p ".dsync/fuse"
					echo "" > ".dsync/controller.sh"
				fi
				(
					: # do the thing in subshell
				)
			else
				echo "Probably you're going to push your Discord webhook to public, please use \"bash ${0##*/} --gitignore\" before this step."
				exit 1
			fi
		else
			echo "Couldn't find the \"${RULES}\" file."
			exit 1
		fi
	;;
	("help")
		echo -e "There is X option:"
	;;
	(*)
		echo "Unknown opiton."
		exit 1
	;;
esac
