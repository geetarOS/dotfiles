#!/bin/sh

# Browser on left DP (DP-3)
niri msg action focus-monitor DP-3
firefox &   # or whatever your browser binary is
sleep 1

# VSCodium on right DP (DP-4)
niri msg action focus-monitor DP-4
codium &
sleep 0.5

# Slack + terminal on laptop screen (eDP-1)
niri msg action focus-monitor eDP-1
slack &
sleep 0.5
ghostty &
