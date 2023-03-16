#!/usr/bin/env bash

# Setup for gaming
yay -S gamescope gamemode mangohud steam

# Setup for streaming
yay -S obs-studio obs-plugin-input-overlay-bin obs-vkcapture-git obs-streamfx
# Setup for AMF encoding with obs
$ORIGWD=$PWD
yay -S lib32-vulkan-amdgpu-pro vulkan-amdgpu-pro
git clone https://github.com/DoomPenguin9/amdgpu-pro-vulkan-and-amf-only.git
cd amdgpu-pro-vulkan-and-amf-only
makepkg -si
cd $ORIGWD
echo "AMD_VULKAN_ICD=RADV" >> /etc/environment
# set obs launch options
# VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_pro_icd64.json OBS_USE_EGL=1 obs


# Install wine 
# lib32-openal doesn't seem to be necessary, install if no audio
yay -S wine alsa-lib alsa-utils lib32-alsa-lib lib32-alsa-plugins lib32-alsa-plugins lib32-libpulse