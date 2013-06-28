#!/bin/sh

THIN="/usr/local/bin/thin"
PORT="8585"

if [ -x "$THIN" ]; then
	$THIN -p $PORT start >cmw.log 2>&1 &
	echo $!>cmw.pid
else
	echo "thin must be installed"
fi

