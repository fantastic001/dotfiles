#!/bin/bash

if [ ! -p ~/.commands.fifo ]; then 
	mkfifo ~/.commands.fifo
fi 

while true; do 
	command=$(head ~/.commands.fifo)
	echo "Executing $command" > ~/.commands.log
	$command  &!
done
