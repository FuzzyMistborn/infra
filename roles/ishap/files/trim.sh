#!/bin/bash

echo "Trimming Dominion"
sudo pct fstrim 200

echo "Trimming Omada"
sudo pct fstrim 202

echo "Trimming Investiture"
sudo pct fstrim 203

echo "Trimming Identity"
sudo pct fstrim 204 --ignore-mountpoint true
