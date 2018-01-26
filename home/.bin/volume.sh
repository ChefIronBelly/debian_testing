#!/bin/sh

vol=$(amixer get Master|awk 'NR==5 {print $4}'|cut -d '%' -f1 | cut -d '[' -f2) #sed -e 's/[//g')
echo $vol
