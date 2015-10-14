#!/bin/bash

# Backup existing hosts
if [ -f "/etc/hosts" ]; then

  echo "Creating a backup of your existing hosts file."
  
  # if hosts.bak does not exist, save current hosts as hosts.bak
  if [[ ! -e "/etc/hosts.bak" ]]; then
    mv /etc/hosts{,.bak}

  # if hosts.bak does exist, save hosts as hosts.bak.n
  else
    num=0

    while [[ -e "/etc/hosts.bak.$num" ]]; do
      (( num++ ))
    done

    mv /etc/hosts "/etc/hosts.bak.$num"
  fi
fi

# Download hosts file and save it to local machine
curl "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" -o "/etc/hosts" >/dev/null 2>&1