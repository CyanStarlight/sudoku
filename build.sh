#!/bin/bash

# Check if we're already in a magic shell
if [[ -z "${MAGIC_HOME}" ]]; then
    echo "Not in magic shell, launching it..."
    # Attempt to find magic shell
    if [ -f "$HOME/.modular/magic/bin/magic" ]; then
        MAGIC_PATH="$HOME/.modular/magic/bin/magic"
    elif [ -f "/usr/local/bin/magic" ]; then
        MAGIC_PATH="/usr/local/bin/magic"
    else
        echo "Error: Could not find magic shell. Please make sure it's installed."
        exit 1
    fi
    
    # Execute this same script but within magic shell
    exec $MAGIC_PATH shell "$0" "$@"
else
    echo "Already in magic shell, proceeding with build..."
    # We're in the magic shell, so build the project
    cd src
    make "$@"
fi