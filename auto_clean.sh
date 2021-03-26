#!/bin/bash

basedir="Demo"

for i in 1 2 3 4 5 6 7 8
do
	dir=$basedir$i
	cd $dir
	if [ -d "build" ];then
		rm -rf build
	fi

	cd ../

done
