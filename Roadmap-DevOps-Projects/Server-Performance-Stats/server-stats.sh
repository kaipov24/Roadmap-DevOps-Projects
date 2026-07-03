#!/bin/bash

# Total CPU usage
top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8 "%"}'

#Total memory usage (Free vs Used including percentage)

free | awk 'NR == 2 {printf "Free %.0f%% vs Used %.0f%%\n", $3*100/$2, $4*100/$2}'

#Total disk usage (Free vs Used including percentage)
df -h --total | tail -1 | awk '{printf "Free %.0f%% vs Used %.0f%%\n", $4*100/$2, $3*100/$2}'

#Top 5 processes by CPU usage
ps -aux --sort=-%cpu | head -5

#Top 5 processes by memory usage
ps -aux --sort=-%mem | head -5