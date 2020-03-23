#!/bin/sh
sed -i \
         -e 's/#080f10/rgb(0%,0%,0%)/g' \
         -e 's/#dcdcdc/rgb(100%,100%,100%)/g' \
    -e 's/#000000/rgb(50%,0%,0%)/g' \
     -e 's/#bb0d3b/rgb(0%,50%,0%)/g' \
     -e 's/#151c1d/rgb(50%,0%,50%)/g' \
     -e 's/#dcdcdc/rgb(0%,0%,50%)/g' \
	"$@"
