#!/bin/bash
sed -i.bak "/id/{s/5/3/}" /etc/inittab

mkdir /root/rhel_disk
echo '/dev/hdc 		/root/rhel_disk 	iso9660 defaults	0 0' >> /etc/fstab
mount -a

#sed -i '$ a\stty erase ^H' /etc/bashrc
echo 'alias vi="vim"
set -o vi
stty erase ^H
stty erase ^?' >> /etc/bashrc

echo '"autocmd BufRead *.pc set filetype
"autocmd BufRead,BufNewFile *.pc     set filetype proc 
autocmd BufEnter *.pc set filetype=esqlc' >> /etc/vimrc
