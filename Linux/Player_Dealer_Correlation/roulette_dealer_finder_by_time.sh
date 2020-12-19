#!/bin/bash

echo "Enter the Date:" $1 # 4-digit Date Ex. 0310
 
echo "Enter the Time:" $2 # Ex. 05:00:00

echo "Enter AM or PM:" $3 # Ex. PM
 
grep $2 $1_Dealer_schedule | grep $3  > roulette_dealer_finder_by_time_Result
