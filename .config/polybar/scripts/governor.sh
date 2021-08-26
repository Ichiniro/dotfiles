#!/bin/sh

case $1 in
    "show-mode")
        cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor ;;
    "set-performance")
        #echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ;;
        cpupower frequency-set -g performance ;;
    "set-powersave")
        #echo powersave | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ;;
        cpupower frequency-set -g powersave ;;
    *)
        echo "Invalid option" ;;
esac

