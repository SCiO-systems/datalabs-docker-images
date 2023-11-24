#!/usr/bin/env bash

echo "Checking if ~/.profile file exists..."

if [ -f "/home/jovyan/.profile" ]; then
  echo " Sourcing /home/jovyan/.profile..."
  source /home/jovyan/.profile
  echo " ~/.profile sourced successfully."
else
  echo " ~/.profile file not found. Skipping sourcing."
fi
