# debian12 & LMDE 6
Tweaks and tips for Debian 12 & LMDE 6

![Debian](https://media1.tenor.com/m/BcVGTaZaNccAAAAC/debian-linux.gif)

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
ufw status
ufw enable
```

## Change swappiness

```
cat /proc/sys/vm/swappiness
# If swappiness is 60:

nano /etc/sysctl.conf
# Add this line to bottom of .conf file:
vm.swappiness=10
reboot
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

## Firefox by Mint has an issue with video playback, to be solved


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
