#!/bin/sh
sed -i \
         -e 's/#1d2324/rgb(0%,0%,0%)/g' \
         -e 's/#dcdcdc/rgb(100%,100%,100%)/g' \
    -e 's/#1d2324/rgb(50%,0%,0%)/g' \
     -e 's/#bb0d3b/rgb(0%,50%,0%)/g' \
     -e 's/#272f30/rgb(50%,0%,50%)/g' \
     -e 's/#dcdcdc/rgb(0%,0%,50%)/g' \
	"$@"
