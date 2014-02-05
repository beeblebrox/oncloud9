#!/bin/bash 
echo -n "Checking for generate.rb...."
if [[ -e generate.rb ]] ; then
  echo "Found!"
else
  echo "missing :("
  echo "Running setup.sh (why didn't you do this already?!)"
  source setup.sh
fi

rvm_test=`type rvm | head -n 1`
echo "Testing RVM: ${rvm_test}"

if [[ ${rvm_test} == "rvm is a function" ]] ; then
  echo "RVM already in envroinment, skipping load."
elif [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
    # First try to load from a user install
    source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
    # Then try to load from a root install
    source "/usr/local/rvm/scripts/rvm"
else
   printf "ERROR: An RVM installation was not found.\n"
fi

echo "Handing process over to ./generate.rb"
exec ./generate.rb ${@}
