## install google-chrome
## install yay

yay -Sy zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting


###

git config --global user.email "etm@etm.com"
git config --global user.name "eatmore01"

###
yay -Sy amneziavpn-bin

sudo pacman -S telegram-desktop

yay -Sy nautilus

yay -Sy alacritty-git
sudo pacman -Sy alacritty

yay -Sy i3status-rust


# fix amnmeziavpn domen resolving https://github.com/amnezia-vpn/amnezia-client/issues/792
sudo systemctl enable systemd-resolved.service && sudo systemctl start systemd-resolved.service

sudo ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

cat >> /etc/NetworkManager/conf.d/dns.conf << EOF
[main]
dns=systemd-resolved
EOF
###


yay -Sy waybar unzip tofi --noconfirm --cleanafter --removemake


# utils
sudo pacman -Sy kubectl terraform k9s --noconfirm

yay -Sy kubectx terragrunt --noconfirm --cleanafter --removemake

git clone https://github.com/eatmore01/kubeswitches.git
cd kubeswitches
go build -o kubeswitches main.go && sudo mv kubeswitches /usr/local/bin/

yay -Sy openvpn3 --noconfirm --cleanafter --removemake


# LIBVIRT + QEMU
sudo pacman -Sy qemu libvirt virt-manager dnsmasq bridge-utils gst-plugins-bad-libs cdrtools --noconfirm

sudo systemctl enable --now libvirtd

sudo usermod -aG libvirt,kvm $USER

virsh --connect qemu:///system list

sudo modprobe kvm

virsh --connect qemu:///system net-start default
virsh --connect qemu:///system net-autostart default
#
###
sudo pacman -S openssh

sudo systemctl start sshd.service
sudo systemctl enable sshd.service

systemctl status sshd.service
####


sudo pacman -S xorg-xrandr

sudo pacman  -Rns nvidia nvidia-utils
sudo mkinitcpio
sudo pacman  -Syu  nvidia nvidia-utils nvidia-settings

yay -Sy main xclip --noconfirm --cleanafter --removemake

yay -Sy obs-studio --noconfirm --cleanafter --removemake


### steam
sudo vim /etc/pacman.conf
# uncomment p[multilib]
sudo pacman -Sy steam --noconfirm

###
➜  ~ yay -Sy fastfetch obsidian vlc --noconfirm --cleanafter --removemake

sudo pacman -S vlc-plugin-ffmpeg

# upd login manager
sudo pacman -Sy lightdm --noconfirm
sudo systemctl enable lightdm --now
sudo systemctl start lightdm

➜  ~ sudo pacman -Rns slim slim-themes sddm


sudo pacman -S bind --noconfirm
## ----
➜  ~ cat /etc/systemd/resolved.conf
[Resolve]
DNS=10.0.0.114 8.8.8.8 8.8.4.4 1.1.1.1 10.0.0.114 10.0.0.22
FallbackDNS=9.9.9.9


➜  ~ sudo systemctl restart systemd-resolved.service

####

➜  ~ sudo pacman -Sy nmap
