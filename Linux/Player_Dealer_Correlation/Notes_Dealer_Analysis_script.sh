#!/bin/bash

echo 'Dealer working during losses :' > Notes_Dealer_Analysis
awk '{print $1, $2, $5, $6}' Dealer_who_was_working_during_losses >> Notes_Dealer_Analysis

echo '                                                          ' >> Notes_Dealer_Analysis 

echo 'Number of times the dealer was working during the losses :' >> Notes_Dealer_Analysis
wc -l Dealer_who_was_working_during_losses > Number
awk '{print $1}' Number >> Notes_Dealer_Analysis
