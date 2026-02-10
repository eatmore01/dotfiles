# fix amnmeziavpn domen resolving https://github.com/amnezia-vpn/amnezia-client/issues/792
sudo systemctl enable systemd-resolved.service && sudo systemctl start systemd-resolved.service

sudo ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

cat >>/etc/NetworkManager/conf.d/dns.conf <<EOF
[main]
dns=systemd-resolved
EOF
#

# LIBVIRT + QEMU
sudo pacman -Sy qemu libvirt virt-manager dnsmasq bridge-utils gst-plugins-bad-libs cdrtools --noconfirm

sudo systemctl enable --now libvirtd

sudo usermod -aG libvirt,kvm $USER

virsh --connect qemu:///system list

sudo modprobe kvm

virsh --connect qemu:///system net-start default
virsh --connect qemu:///system net-autostart default
#
# steam
sudo vim /etc/pacman.conf
## uncomment p[multilib]
sudo pacman -Sy steam --noconfirm
#

# ?????????
➜ ~ cat /etc/systemd/resolved.conf
[Resolve]
DNS=10.0.0.114 8.8.8.8 8.8.4.4 1.1.1.1 10.0.0.114 10.0.0.22
FallbackDNS=9.9.9.9

➜ ~ sudo systemctl restart systemd-resolved.service
#

#
#
#
#
#
#
### change kernel to lts version
#➜  ~ ls /lib/modules/
# 6.18.6-arch1-1 -> 6.12.68-1-lts
365 sudo pacman -Sy linux-lts
366 clear
367 sudo vim /etc/default/grub
# GRUB_DEFAULT="saved"
# GRUB_SAVEDEFAULT=true
# GRUB_DISABLE_SUBMENU=y
368 sudo grub-mkconfig -o /boot/grub/grub.cfg
369 sudo pacman -Sy linux-lts-headers

#helpers
➜ ~ sudo mkinitcpio -p linux-lts
cat /etc/mkinitcpio.conf | grep -E '^(MODULES|HOOKS)'\n

# for f2fs in /etc/fstab delete the following option for /root and /home mount point
# discard_unit=block,checkpoint_merge,lookup_mode=perf
# features for kernel 6.18+ not for 6.12
sudo findmnt --verify

# sudo reboot now
#
#
#
#
sudo pacman -Sy nodejs npm --noconfirm
sudo npm install --global yarn

####
/etc/sysctl.conf

net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
# udp for xray optimization
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192

####

#!/bin/sh
INTERFACE=$1
STATUS=$2

if [ "$STATUS" = "up" ] && echo "$INTERFACE" | grep -q "^tun"; then
  /usr/bin/ip link set "$INTERFACE" mtu 1300
fi

sudo vim /etc/NetworkManager/dispatcher.d/02-tun-mtu

sudo chmod +x /etc/NetworkManager/dispatcher.d/02-tun-mtu
####
