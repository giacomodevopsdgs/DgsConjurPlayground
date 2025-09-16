#!/bin/bash
echo "Deleting current session and logging off..."

# Delete saved credentials
rm -f /home/"$USER"/.netrc
rm -f /home/"$USER"/.conjurrc

echo "Logged off, you will need to authenticate again."
