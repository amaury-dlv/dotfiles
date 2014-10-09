#!/bin/sh

for file in dot.*; do
  name=${file/dot/}
  echo "Installing $name";
  ln -snf `pwd`/$file ~/$name
done

echo "Installing vim bundles"
vim +BundleInstall +qall

echo "Remap Caps Lock to Ctrl"

if [ "$(uname)" = "Darwin" ];
then
  vendor=$(echo $(ioreg -n IOHIDKeyboard -r | grep -e VendorID\" | cut -d'=' -f2))
  product=$(echo $(ioreg -n IOHIDKeyboard -r | grep -e ProductID\" | cut -d'=' -f2))

  defaults -currentHost write NSGlobalDomain com.apple.keyboard.modifiermapping.${vendor}-${product}-0 -array '<array><dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict></array>'
fi
