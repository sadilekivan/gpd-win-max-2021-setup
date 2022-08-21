#!/bin/bash
# Sourced from:
# https://wiki.archlinux.org/title/GPD_Win_Max
# https://forum.qubes-os.org/t/gpd-win-max-2021-intel-i7-1195g7/7376/4
# https://www.reddit.com/r/archlinux/comments/v0x3c4/psa_if_you_run_kernel_518_with_nvidia_pass_ibtoff/

kernel_grub_parameters() {
# Kernel parameters
# Display changes name when another display is plugged in at boot (thus DSI1 and DSI-1)
echo "Please edit /etc/default/grub to fit your needs with:"
echo "fbcon=rotate:1 video=DSI1:panel_orientation=right_side_up video=DSI-1:panel_orientation=right_side_up ibt=off nvidia_drm.modeset=1"
echo "Don't forget to update-grub"
}

xorg_conf() {
# XORG configuration
# Screen rotation
cat << EOF | sudo tee /etc/X11/xorg.conf.d/30-internal-monitor-rotate.conf
Section "Monitor"
  Identifier  "DSI1"
  Option      "Rotate"  "right"
EndSection
EOF
# Touchscreen matrix rotation
cat << EOF | sudo tee /etc/X11/xorg.conf.d/99-internal-touchscreen-rotate.conf
Section "InputClass"
  Identifier    "calibration"
  MatchProduct  "Goodix Capacitive TouchScreen"
  Option        "TransformationMatrix"          "0 1 0 -1 0 1 0 0 1"
EndSection
EOF
}

sound_intel_modprobe() {
# Sound on speakers
cat << EOF | sudo tee /etc/modprobe.d/alsa-base.conf
options snd-intel-dspcfg dsp_driver=1
EOF
}

mute_key() {
# Fix mute key - Does not work
cat << EOF | sudo tee /etc/udev/hwdb.d/90-gpd-rules.hwdb
evdev:atkbd:dmi:bvn*:bvr*:bd*:svnGPD:pnG1619-01:pvr*
 KEYBOARD_KEY_a0=!mute
EOF
}

sleep_display() {
# TODO Maybe simulate reconnection of the internal display with a systemd service, which would make sleep/wake fully functional.
# Sleep settings so screen doesnt stay black, fan keeps goin in sleep :C
# TODO this wont persist yet
echo s2idle | sudo tee /sys/power/mem_sleep
}

monitor_xml_symlink() {
# GDM lock screen rotation
sudo ln -s $HOME/.config/monitors.xml /var/lib/gdm/.config/monitors.xml
}

light_dm_rotation() {
# Have not used this yet
# LightDM Greeter (Login Screen) Display Rotation
cat << EOF | sudo tee /etc/lightdm/greeter_setup.sh
#!/bin/bash
xrandr -o right
for display in {"DSI1","DSI-1"}
    do
    xinput map-to-output "pointer:Goodix Capacative TouchScreen" $display
done
exit 0
EOF
cat << EOF | sudo tee /etc/lightdm/lightdm.conf
[Seat:*]
greeter-setup-script=/etc/lightdm/greeter_setup.sh
EOF
}

arch_fixes() {
kernel_grub_parameters
xorg_conf
sound_intel_modprobe
mute_key
sleep_display
}

fedora_fixes() {
kernel_grub_parameters
xorg_conf
sound_intel_modprobe
mute_key
sleep_display
monitor_xml_symlink
light_dm_rotation
}

echo "Going to run $1"
$1