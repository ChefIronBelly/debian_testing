#!/bin/sh
#
# z3bra - (c) wtfpl 2014
# Create a small popup with the given text
#
# depends: lemonbar, wattr and common sense

. $HOME/.wmrc

# alpha
a="#cc"
b="#00"

# default colors
bg="${a}${C0}"
fg="${a}${C7}"
sp="${a}${C1}"

default_geometry() {
    # get screen size
    #x=$(wattr w `lsw -r`)
    #y=$(wattr h `lsw -r`)

    width=1820
    height=16

    offy=0
#    offx=$(( x - x/2 - $width/2 ))
    offx=100

    echo "${width}x${height}+${offx}+${offy}"
}

test "$#" -lt 1 && exit 1

while getopts "d:g:h" opt; do
    case $opt in
        d) SLEEP=$OPTARG ;;
        g) GEOM=$OPTARG  ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

GEOM=${GEOM:-$(default_geometry)}
SLEEP=${SLEEP:-5}

(echo "%{l}$@"; sleep $SLEEP) | lemonbar -d -g $GEOM -f $FONT -B $bg -F $fg
