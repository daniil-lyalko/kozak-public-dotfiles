#!/bin/bash

# WSL clipboard script
# This script handles clipboard operations between WSL and Windows

# Function to copy to Windows clipboard
copy_to_windows() {
    if [ -t 0 ]; then
        # If stdin is a terminal, read from arguments
        echo "$@" | xclip -selection clipboard
    else
        # If stdin is a pipe, read from stdin
        xclip -selection clipboard
    fi
}

# Function to paste from Windows clipboard
paste_from_windows() {
    xclip -selection clipboard -o
}

# Main script
case "$1" in
    "copy")
        shift
        copy_to_windows "$@"
        ;;
    "paste")
        paste_from_windows
        ;;
    *)
        echo "Usage: $0 {copy|paste}"
        exit 1
        ;;
esac 