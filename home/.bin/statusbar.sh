#!/bin/sh

. $HOME/.wmrc

# alpha
a="#cc"
b="#00"

# default colors
bg="${a}${C0}"
fg="${a}${C7}"
sp="${a}${C4}"
red="${a}${C1}"
grn="${a}${C2}"

# default geometry
default_geometry() {
width=1920 # values like 1280, 1440, 1920, etc
height=20
offy=0
offx=0

echo "${width}x${height}+${offx}+${offy}"
}

GEOM=${GEOM:-$(default_geometry)}

statusbar() {
	
groups() {
    groups=$(gind.sh)
    echo $groups
}

mem() {
	mem=$(free -m | awk 'NR==2 {print $3}')
	echo $mem
}

memory() {
        mem=$(free -m | awk 'NR==2 {print $3}')
            if [[ $mem -ge "500" ]]; then
                m="$ALERT"$SEP"$mem"
            elif [[ $mem -gt "300" ]] && [[ $mem -lt "500" ]]; then
                m="$WARN"$SEP"$mem"
            else
                m="$GOOD"$SEP"$mem"
            fi
        echo "$PLAIN$glymem$CLR$m$CLR"
}



ip() {
    ip=$(if_ip.sh)
    echo $ip
}

vol() {
	vol=$(amixer get Master|awk 'NR==6 {print $5}'|cut -d '%' -f1 | cut -d '[' -f2)
	echo $vol
}

dateclock() {
    datetime=$(date +" %a, %b %d")
    echo $datetime
}

clock() {
    time=$(date +" %I:%M")
    echo $time
}

echo %{l}%{F${sp}}" >> "%{F-}%{F${fg}}"0x"$(groups)%{F-}%{c}%{F${sp}}%{F-}%{r}%{F${fg}}mem: $(mem)%{F-}%{F${sp}}" >> "%{F-}%{F${fg}}ip: $(ip)%{F-}%{F${sp}}" >> "%{F-}%{F${fg}}vol: $(vol)%{F-}%{F${sp}}" >> "%{F-}%{F${fg}} $(dateclock)%{F-}%{F${sp}}" @ "%{F-}%{F${fg}}$(clock)%{F-}%{F${sp}}" "%{F-}
}

while true
 do
   echo "$(statusbar)"
   sleep 0.5
      
 done |  lemonbar -p -d -g $GEOM -f $FONT -f $ICOFONT -B $bg
