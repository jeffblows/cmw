#!/bin/sh

PID_FILE="./cmw.pid"

if [ -e $PID_FILE ]; then
	kill `cat $PID_FILE`
fi
