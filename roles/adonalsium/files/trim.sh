#!/bin/bash

echo "Trimming Honor"
sudo pct fstrim 201

echo "Trimming Connection"
sudo pct fstrim 211

echo "Trimming Invention"
sudo pct fstrim 210

echo "Trimming Endowment"
sudo pct fstrim 250

echo "Trimming Autonomy"
sudo pct fstrim 251

echo "Trimming Cultivation"
sudo pct fstrim 252

echo "Trimming Preservation"
sudo pct fstrim 253
