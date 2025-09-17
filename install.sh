#!/bin/bash

for file in dot.*; do
  name=${file/dot/}
  echo "Installing $name";
  ln -snf "`pwd`/$file" ~/$name
done

ln -sn `pwd`/bin ~/bin

echo "Installing vim bundles"
git submodule update --init --recursive
#vim +BundleInstall +qall
