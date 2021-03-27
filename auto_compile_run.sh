#!/bin/bash

basedir="Demo"

for i in 1 2 3 4 5 6 7 8
do
	dir=$basedir$i
	cd $dir
	if [ ! -d "build" ]; then
		mkdir build
	fi

	cd build
	if [ ! -f "demo" ]; then
			cmake ..
			make
	fi

	echo "************" + ${dir} + "result**********"
	if [ -f "demo" ]; then
    	./demo
	fi
	cd ../../

done
