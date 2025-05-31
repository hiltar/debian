# debian
Tweaks and tips for Debian. Themes and settings for GNOME included.

![Debian](https://media1.tenor.com/m/BcVGTaZaNccAAAAC/debian-linux.gif)

---

# Installation guide - minimal

## Flashing netinst iso
Download a netinst iso from Debian: `https://cdimage.debian.org/cdimage/release/current/amd64/iso-cd/`, file called `debian-<version>-amd64-netinst.iso`   
Flash the netinst iso into USB flash stick with `Fedora media writer` or similar.  

## Installation
Use `Graphical install` to install Debian  
Deselect any desktop selection and select `standard system utilities`
![DE selection](https://github.com/user-attachments/assets/6403e7ed-3f68-4a43-9f3a-bfe2a2df509c)

After successful installation login as root  
**NOTE: You may update to Debian 13 Trixie at this point** 
```
apt install sudo
adduser <user> sudo # Change user

sudo apt update
sudo apt install gnome-core -y
sudo apt purge ifupdown -y # Gnome uses Network Manager - Unnecessary package
sudo shutdown -r now

sudo nano /etc/NetworkManager/NetworkManager.conf

[ifupdown]
managed = true

sudo shutdown -r now

# Packages
# minimal
sudo apt install gnome-session nautilus gnome-terminal firefox-esr -y

# Minimal with additional packages
sudo apt install gnome-session nautilus gnome-terminal firefox-esr git wget curl flatpak gnome-software-plugin-flatpak fastfetch gnome-tweaks -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

# Update to Debian 13 Trixie
```
sudo sed -i 's/bookworm/trixie/g' /etc/apt/sources.list
sudo apt update
sudo apt full-upgrade --autoremove
```

---

# Tweaks

## Faster boot time

```
systemd-analyze blame
# Unnecessary services to be disabled

# This service waits for internet connection before proceeding to login screen
# Disabling this don't cause any issues 
systemctl disable NetworkManager-wait-online.service
```

## Improve battery life

```
# Install tlp
apt update && apt install tlp
# If laptop is Thinkpad
apt install tp-smapi-dkms acpi-call-dkms
reboot
```

## Enable firewall

```
sudo apt install ufw -y
ufw status
ufw enable
```

## sysctl.conf

```
### Change Swappiness
nano /etc/sysctl.conf
vm.swappiness=10
reboot

### Increase max map count
nano /etc/sysctl.conf
vm.max_map_count=524288
sysctl -p
```

---

# Backports
Enable backports repository:
```
nano /etc/apt/sources.list

deb http://deb.debian.org/debian bookworm-backports main
```

`apt update`

## Packages from backports
```
apt install -t bookworm-backports mesa-vulkan-drivers -y
apt install -t bookworm-backports linux-image-amd64 -y
apt install -t bookworm-backports firmware-amd-graphics -y
```

---

# Issues

## Sleep loop while docked (Thunderbolt 3 & 4 docks)

```
cat /etc/systemd/logind.conf | grep Lid
nano /etc/systemd/logind.conf
# Uncomment these lines:
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

## Thunderbolt 3 dock ethernet stop working
`nmcli device status`

```
DEVICE           TYPE      STATE                                    CONNECTION
enx3ce1a1c0093a  ethernet  connecting (getting IP configuration)    Wired connection 1
lo               loopback  connected (externally)                   lo
eno1             ethernet  unavailable                              --
enp2s0           ethernet  unavailable                              --
wlp3s0           wifi      unavailable                              --
```

Check logs: `dmesg | grep enx3ce1a1c0093a`
```
[  462.038774] r8152 2-1.1.2:1.0 enx3ce1a1c0093a: Tx status -71
[  466.011891] r8152 2-1.1.2:1.0 enx3ce1a1c0093a: Tx status -71
[  466.025828] [UFW BLOCK] IN=enx3ce1a1c0093a OUT= MAC=01:00:5e:00:00:02:d0:c9:e3:9a:e2:20:08:00 SRC=192.168.68.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0x00 TTL=1 ID=12152 DF PROTO=2
```

Add allow rule for `enx3ce1a1c0093a`
```
sudo ufw allow out on enx3ce1a1c0093a
sudo ufw reload
sudo ufw status
```

```
Status: active

To                         Action      From
--                         ------      ----
Anywhere                   ALLOW OUT   Anywhere on enx3ce1a1c0093a
Anywhere (v6)              ALLOW OUT   Anywhere (v6) on enx3ce1a1c0093a
```

Add into interfaces file: `nano /etc/network/interfaces`
```
allow-hotplug eno1
allow-hotplug enx3ce1a1c0093a
iface eno1 inet dhcp
iface enx3ce1a1c0093a inet dhcp
```

`nmcli device status`
```
DEVICE           TYPE      STATE                   CONNECTION         
enx3ce1a1c0093a  ethernet  connected               Wired connection 1 
lo               loopback  connected (externally)  lo                 
eno1             ethernet  unavailable             --                 
enp2s0           ethernet  unavailable             --                 
wlp3s0           wifi      unavailable             --
```



---

# Other

## Export & Import gnome-terminal profile

```
dconf dump /org/gnome/terminal/legacy/profiles:/ > gnome-terminal-profiles.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
rm gnome-terminal-profiles.dconf
reboot
```

## Export & Import Cinnamon settings
```
dconf dump /org/cinnamon/ > cinnamon_settings.dconf
dconf load /org/cinnamon/ < cinnamon_settings.dconf
rm cinnamon_settings.dconf
reboot
```

## Export & Import Gnome settings
```
dconf dump /org/gnome/ > gnome_settings.dconf
dconf load /org/gnome/ < gnome_settings.dconf
rm gnome_settings.dconf
reboot
```
