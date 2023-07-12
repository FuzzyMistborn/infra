#!/bin/bash

echo "Trimming Dominion"
sudo pct fstrim 200

echo "Trimming Honor"
sudo pct fstrim 201

echo "Trimming Omada"
sudo pct fstrim 202

echo "Trimming Drone"
sudo pct fstrim 203

echo "Trimming Invention"
sudo pct fstrim 210

echo "Trimming Connection"
sudo pct fstrim 211

echo "Trimming Endowment"
sudo pct fstrim 250

echo "Trimming Autonomy"
sudo pct fstrim 251

echo "Trimming Cultivation"
sudo pct fstrim 252

echo "Trimming Preservation"
sudo pct fstrim 253
