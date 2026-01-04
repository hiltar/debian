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
sudo apt install gnome-session nautilus ptyxis firefox-esr git wget curl flatpak gnome-software-plugin-flatpak gnome-tweaks -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

# Update to Debian 13 Trixie
```
sudo sed -i 's/bookworm/trixie/g' /etc/apt/sources.list
sudo apt update
sudo apt full-upgrade --autoremove
```

# LUKS + TPM2 encryption
```
sudo apt install systemd-cryptsetup tpm2-tools clevis clevis-luks clevis-tpm2

lsblk -f
# nvme0n1p3 crypto_LUKS

# Bind TPM2 to partition
clevis luks bind -d /dev/nvme0n1p3 tpm2 '{"pcr_ids":"2,7"}'

# Test TPM2
cryptsetup luksClose cryptroot
cryptsetup luksOpen /dev/nvme0n1p3 cryptroot

# /etc/crypttab
cryptroot UUID=<uuid> none luks,discard
# initramfs
update-initramfs -u -k all
```
# Tweaks

## Faster boot time

```
systemd-analyze blame
# Unnecessary services to be disabled

# This service waits for internet connection before proceeding to login screen
# Disabling this don't cause any issues 
systemctl disable NetworkManager-wait-online.service
```

## Better fonts

```
sudo nano /etc/environment

FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

sudo reboot
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
