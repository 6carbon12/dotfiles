#!/bin/sh
if rfkill list wifi | grep -q "Soft blocked: no"; then
  echo true
else
  echo false
fi
