#!/bin/bash

cd /eecs/home/vavanv/Documents/EECS_3311/Lab4

student=./Tracker/tests/acceptance/student

instructor=./Tracker/tests/acceptance/instructor

s_results=./Tracker/tests/acceptance/student

i_results=./Tracker/tests/acceptance/instructor



mkdir -p $s_results

mkdir -p $i_results



for i in "$instructor"/*.txt

do

  ./Tracker/EIFGENs/tictac/W_code/tictac -b $i > $i_results/actual.$(basename $i)

  ./oracle.exe -b $i > $i_results/expected.$(basename $i)

  diff -qs $i_results/expected.$(basename $i) $i_results/actual.$(basename $i)

done



for i in $student/*.txt

do

  ./Tracker/EIFGENs/tictac/W_code/tictac -b $i > $s_results/actual.$(basename $i)

  ./oracle.exe -b $i > $s_results/expected.$(basename $i)

  diff -qs $s_results/expected.$(basename $i) $s_results/actual.$(basename $i)

done
