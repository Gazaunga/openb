## Preliminary path definitions.  For security reasons (and bad programming
## assumptions) you should always append entries to PATH, not prepend them.
appendpath () {
	[ $# -eq 2 ] && PATHVAR=$2 || PATHVAR=PATH
	[ -d "$1" ] || return
	eval echo \$$PATHVAR | grep -q "\(:\|^\)$1\(:\|$\)" && return
	eval export $PATHVAR="\$$PATHVAR:$1"
}
prependpath () {
	[ $# -eq 2 ] && PATHVAR=$2 || PATHVAR=PATH
	[ -d "$1" ] || return
	eval echo \$$PATHVAR | grep -q "\(:\|^\)$1\(:\|$\)" && return
	eval export $PATHVAR="$1:\$$PATHVAR"
}

## Use this to override system executables.
prependpath "${HOME}/bin"
prependpath "{$HOME}/.gem/ruby/2.*.*/bin"

## TeXlive
TEXDIR="${TEXDIR:-/usr/local/texlive}"
if [ -d "${TEXDIR}" ]; then
	TEXYEAR=$(/bin/ls -1r "${TEXDIR}" | grep -m1 "[0-9]\{4\}")
	TEXDISTRO=$(uname -m)-$(uname | awk '{print tolower($0)}')
	TEXFOLDER="${TEXDIR}/${TEXYEAR}/bin/${TEXDISTRO}"
	if [ -d "${TEXFOLDER}" ]; then
		appendpath $TEXFOLDER
		## Same for INFOPATH, which should have an empty entry
		## at the end, otherwise Emacs will not use standard locations.
		prependpath ${TEXDIR}/${TEXYEAR}/texmf/doc/info INFOPATH

		if [ "$(uname -o)" = "GNU/Linux" ]; then
			## Under GNU/Linux, MANPATH must contain one empty entry for 'man' to
			## lookup the default database.  Since BSD uses 'manpath' utility, the
			## MANPATH variable is not needed.
			prependpath ${TEXDIR}/${TEXYEAR}/texmf/doc/man MANPATH
		fi
	fi
	unset TEXYEAR
	unset TEXDISTRO
	unset TEXFOLDER
fi
unset TEXDIR
export BIBINPUTS=~/Documents/Bibliographies

## Go
if [ -d "$HOME/.go" ]; then
	export GOPATH=~/.go:~/.go-tools
	appendpath "$HOME/.go-tools/bin"
	appendpath "$HOME/.go/bin"
	command -v godoc >/dev/null 2>&1 && godoc -http :6060 -play 2>/dev/null &
fi

## Remove less history.
LESSHISTFILE='-'

## Manpage.
export MANPAGER="less -s"
export MANWIDTH=80

export TIME_STYLE=+"|%Y-%m-%d %H:%M:%S|"

## Set sound volume.
	amixer 2>/dev/null | grep -q PCM && amixer set PCM 100%

	## External device auto-mounting.
	## If already started, the new process will replace the old one.
	if command -v udiskie >/dev/null 2>&1; then
		udiskie &
	elif command -v devmon >/dev/null 2>&1; then
		devmon &
	else
		udisks-automount &
	fi
fi

## End: Source .bashrc. The rc file should guard against non-interactive shells.
[ "$(ps -o comm= $$)" != bash ] && return
[ -f ~/.bashrc ] && . ~/.bashrc
