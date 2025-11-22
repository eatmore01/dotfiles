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


# fix amnmeziavpn domen resolving
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


yay -Sy openvpn3 --noconfirm --cleanafter --removemake


# LIBVIRT + QEMU
sudo pacman -Sy gst-plugins-bad-libs

sudo pacman -Sy qemu libvirt virt-manager dnsmasq bridge-utils

sudo systemctl enable --now libvirtd

sudo usermod -aG libvirt,kvm $USER

virsh --connect qemu:///system list

sudo pacman -Sy cdrtools

sudo modprobe kvm

virsh --connect qemu:///system net-start default
virsh --connect qemu:///system net-autostart default

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