#!/bin/bash

grep '-' 0310_win_loss_player_data > 0310_loss_data

echo "Total losses occurred on 0310 : " > Notes_Player_Analysis 
grep '-' 0310_win_loss_player_data | wc -l  >> Notes_Player_Analysis

echo "Number of times Mylie played on 0310 :" >> Notes_Player_Analysis
grep -w 'Mylie' 0310_loss_data | wc -l >> Notes_Player_Analysis

echo "Time the losses occureed everyday : " >> Notes_Player_Analysis 
awk '{print $1}' 0310_loss_data >> Notes_Player_Analysis

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> Notes_Player_Analysis

grep '-' 0312_win_loss_player_data > 0312_loss_data

echo "Total losses occurred on 0312 : " >> Notes_Player_Analysis
grep '-' 0312_win_loss_player_data | wc -l >> Notes_Player_Analysis

echo "Number of times Mylie played on 0312 :" >> Notes_Player_Analysis
grep -w 'Mylie' 0312_loss_data | wc -l >> Notes_Player_Analysis

echo "Time the losses occureed everyday : " >> Notes_Player_Analysis
awk '{print $1}' 0312_loss_data >> Notes_Player_Analysis

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> Notes_Player_Analysis

grep '-' 0315_win_loss_player_data > 0315_loss_data

echo "Total losses occurred on 0315 : " >> Notes_Player_Analysis
grep '-' 0315_win_loss_player_data | wc -l >> Notes_Player_Analysis

echo "Number of times Mylie played on 0315 :" >> Notes_Player_Analysis
grep -w 'Mylie' 0315_loss_data | wc -l >> Notes_Player_Analysis

echo "Time the losses occureed everyday : " >> Notes_Player_Analysis
awk '{print $1}' 0315_loss_data >> Notes_Player_Analysis

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> Notes_Player_Analysis
