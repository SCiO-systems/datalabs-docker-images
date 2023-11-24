#!/usr/bin/env bash

echo "Checking if ~/.bashrc file exists..."

if [ -f "/home/jovyan/.bashrc" ]; then
  echo " Sourcing /home/jovyan/.bashrc..."
  source /home/jovyan/.bashrc
  echo " ~/.bashrc sourced successfully."
else
  echo " ~/.bashrc file not found. Skipping sourcing."
fi
