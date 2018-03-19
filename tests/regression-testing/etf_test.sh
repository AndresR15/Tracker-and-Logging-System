#!/bin/bash

if [ $# -eq 0 ]; then

	echo "Building executable from ETF_Test."
	ghc ETF_Test.hs


	echo "Remove *.o and *.hi files"
	rm -rf *.hi
	rm -rf *.o
	
	echo "Running ./ETF_Test"
	./ETF_Test
else
	echo "Usage example: ./etf_test.sh"
fi
