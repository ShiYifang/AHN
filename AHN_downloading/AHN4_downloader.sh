#!/bin/bash

while read url; do
	curl $url -O /project/lidarac/Data/AHN4
done < urls.txt
