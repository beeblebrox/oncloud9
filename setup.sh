#!/bin/bash

cat rvm-installer | bash -s stable --autolibs=enable

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
    # First try to load from a user install
    source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
    # Then try to load from a root install
    source "/usr/local/rvm/scripts/rvm"
else
   printf "ERROR: An RVM installation was not found.\n"
fi
type `which rvm` | head -n 1
rvm install 2.0.0
rvm use 2.0.0
gem install foreman
# Must generate a ruby script with the correct interuperter
echo "Generating generate.rb"
ENV=`which env`
{
  echo "#!${ENV} ruby"
  cat pre_generate.rb
} > generate.rb
chmod +x generate.rb
echo "Now generate.sh can be ran as normal."
echo "DONE!"

