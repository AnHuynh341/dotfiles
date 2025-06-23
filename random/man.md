#keymap
  #Hyprland
    Launching:
      meta + E: dolphin
      meta + T: terminal
      meta + D: dmenu
      meta + C: clipboard manager
      meta + A: swaync 
      meta + Z: power menu
    Interacting:
      meta + R + arrow: resize window
      meta + shift + number: move window to workspace [number]
      meta +  H/J/K/L: move focus left/down/up/right
      meta + Q: kill window
    
  #tmux
     ctrl + T: new window
     alt + H: horizontal split
     alt + V: vertical split
     alt + arrow: switch pane
     ctrl + alt + up/down: swap pane 
     shift + tab: switch window

  



 
#command
  #file-transfer
    rsync -avh --progress ~/source/ ~/destination/ && sync



#UEFI-GRUB-Recovery
 step 1. manual boot
> ls
> ls (hdx,gpty)/
> set root=(hd1,gpt4)    //depends 
> linux /vmlinuz-<version> root=/dev/sdb5 
> initrd /initramfs-<version>.img
> boot

 step 2. fix GRUB
> sudo mount /dev/sdb1 /boot/efi
> sudo grub2-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Fedora --recheck --force
> sudo grub2-mkconfig -o /boot/grub2/grub.cfg
> sudo cp /boot/grub2/grub.cfg /boot/efi/EFI/fedora/grub.cfg

 step 3. check EFI boot entries
> sudo efibootmgr
