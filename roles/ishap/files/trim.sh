#!/bin/bash

echo "Trimming Dominion"
sudo pct fstrim 200

echo "Trimming Drone"
sudo pct fstrim 203

echo "Trimming Omada"
sudo pct fstrim 202
