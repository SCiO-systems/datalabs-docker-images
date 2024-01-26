#!/usr/bin/env bash

echo "Checking if ~/.bashrc file exists..."

if [ -f "/home/jovyan/.bashrc" ]; then
  echo " Sourcing /home/jovyan/.bashrc..."
  source /home/jovyan/.bashrc
  echo " ~/.bashrc sourced successfully."
else
  echo " No ~/.profile file found. Copying original .bashrc file and sourcing ~/.profile..."
  sudo cp /opt/.bashrc ~/.profile
  source ~/.profile
  echo " ~/.profile sourced successfully."
fi