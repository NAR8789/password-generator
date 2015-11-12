#!/bin/sh

curl -s https://raw.githubusercontent.com/atebits/Words/master/Words/en.txt | egrep '^.{3,7}$' > word_list.txt
