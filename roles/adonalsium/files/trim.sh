#!/bin/bash

echo "Trimming Honor"
sudo pct fstrim 201

echo "Trimming Invention"
sudo pct fstrim 210

echo "Trimming Endowment"
sudo pct fstrim 250 --ignore-mountpoint true

echo "Trimming Autonomy"
sudo pct fstrim 251

echo "Trimming Cultivation"
sudo pct fstrim 252

echo "Trimming Preservation"
sudo pct fstrim 253
