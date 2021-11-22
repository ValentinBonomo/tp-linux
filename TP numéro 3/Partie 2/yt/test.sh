#!/bin/bash

while [ -s test.txt ]
do
	head -n 1 test.txt >> supprimé.txt
	sed -i '1d' test.txt
done
