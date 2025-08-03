#!/bin/bash

# Check if any tmux server exists
if ! tmux has-session 2>/dev/null; then
  exec tmux new-session -s m
fi

# If sessions exist, check for attached clients
attached_clients=$(tmux list-clients 2>/dev/null | wc -l)

if [ "$attached_clients" -eq 0 ]; then
  # No one is attached – attach
  exec tmux attach-session
else
  # Someone is already attached – skip tmux
  exec zsh
fi

