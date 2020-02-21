#!/bin/bash

function aur {
	cd /tmp
	git clone https://aur.archlinux.org/$1.git
	chown -R $username:users /tmp/$1
	chown -R $username:users /tmp/$1/PKGBUILD
	cd $1
	-u $username makepkg -si --noconfirm
	cd ..
	rm -rf $1
}

echo '--------------------------------------------------'
echo '|              Установка драйверов               |'
echo '--------------------------------------------------'

echo '>> Установка xorg и mesa'
#pacman -Sy xorg-server xorg-xinit mesa --noconfirm

mkdir -p /etc/X11/xorg.conf.d
cd /etc/X11/xorg.conf.d/
case $ucode in
	intel)
		#pacman -S libva libva-intel-driver --noconfirm
		;;
	*)
		#pacman -S libva libva-mesa-driver --noconfirm
		;;
esac

#echo 'Тачпад'
##pacman -Sy xf86-input-synaptics --noconfirm
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/X11/10-synaptics.conf'

#echo '>> Установка поддержки файловых систем NTFS exFAT'
##pacman -Sy ntfs-3g exfat-utils --noconfirm

#echo '>> Видеокарта'
#echo '>intel'
##pacman -Sy xf86-video-intel --noconfirm
## Загрузка готовой конфигурации intel 
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/20-intel.conf'
#echo ' Настрока DRM'
#sed -i 's/MODULES=(/MODULES=(i915 /g' /etc/mkinitcpio.conf

#echo '>nvidia'
## Установка nvidia-390xx Для видеокарт серии GeForce 400/500 [NVCx и NVDx] примерно из 2010-2011
##pacman -Sy nvidia-390xx nvidia-390xx-utils lib32-nvidia-390xx-utils opencl-nvidia-390xx nvidia-390xx-settings --noconfirm
## Переключить на дискретную карту nvidia на ноутбуках
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/X11/20-nvidia-prime.conf'

##pacman -Sy nvidia nvidia-utils lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia nvidia nvidia-prime nvidia-settings --noconfirm
#echo '>> Настрока DRM nVidia'
#sed -i 's/MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /g' /etc/mkinitcpio.conf
## Настроить nvidia на ноутбуках с использованием PRIME Render Offload
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/X11/20-nvidia.conf'
## После перезагрузки выполнить sudo nvidia-xconfig для настройки видеокары
## sudo nvidia-xconfig --prime необходимо для конфигурирования драйвера в совместимом режиме с картой intel

echo '--------------------------------------------------'
echo '|           Установка Display Manager            |'
echo '--------------------------------------------------'
# раскомментировать блок SDDM или LigtDM
#echo '>> Установка LightDM'
#pacman -Sy lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm
#cd /etc/lightdm/
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/lightdm/lightdm.conf'
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/lightdm/display_setup.sh'
#chmod +x display_setup.sh
#systemctl enable lightdm.service
#cd ~/

echo '>> Установка sddm'
pacman -Sy sddm sddm-kcm --noconfirm
systemctl enable sddm

#echo '>> Настройка SDDM для xrandr'
##pacman -S xorg-xrandr --noconfirm
#echo 'xrandr --auto' >> /usr/share/sddm/scripts/Xsetup
#echo 'xrandr --dpi 75' >> /usr/share/sddm/scripts/Xsetup

echo '>> Установка настройки сети'
pacman -Sy networkmanager samba --noconfirm
systemctl enable NetworkManager

echo '--------------------------------------------------'
echo '|         Установка Desktop Environment          |'
echo '--------------------------------------------------'
#echo '>> Gnome'
#pacman -Sy gnome gnome-shell gnome-extra --noconfirm

#echo '>> Cinnamon'
##pacman -Sy cinnamon cinnamon-translations --noconfirm
##pacman -Sy gnomme-terminal

#echo '>> Deepin'
##pacman -Sy deepin --noconfirm

echo '>> KDE Plasma'
#pacman -Sy phonon-qt5-vlc --noconfirm
#pacman -Sy plasma-meta kdebase packagekit-qt5 kde-gtk-config --noconfirm
echo '>  Дополнительный софт для KDE'
#pacman -Sy konsole partitionmanager ark spectacle okular kcalc --noconfirm
#pacman -Sy aspell aspell-ru --noconfirm
pacman -Rsnc konqueror kwrite --noconfirm

#echo '>> Bluetooth pulseaudio и alsa поддержка звука'
##pacman -Sy bluez bluez-utils bluedevil pulseaudio-bluetooth alsa-utils pulseaudio-equalizer-ladspa --noconfirm
#systemctl enable bluetooth.service

#echo 'XFCE'
##pacman -Sy xfce4 xfce4-goodies --noconfirm

echo '--------------------------------------------------'
echo '|        Установка дополнительного софта         |'
echo '--------------------------------------------------'

echo '>> Настройка папок пользователя'
#pacman -Sy xdg-user-dirs --noconfirm

#pacman -Syu
#pacman -Sy git --noconfirm

echo '>> Установка pacaur'
aur auracle-git
aur pacaur

#echo '>> Установка микрокода для aic94xx и wd719x'
#aur aic94xx-firmware
#aur wd719x-firmware

mkinitcpio -p linux

#echo '>> Установка octopi'
#aur alpm_octopi_utils
#aur octopi

#echo '>> Установка Double Commander'
##pacman -S doublecmd-qt5 --noconfirm

#echo '>> Установка Firewall'
##pacman -Sy ufw gufw --noconfirm
#systemctl enable ufw.service

#echo '>> Установка LibreOffice'
##pacman -Sy libreoffice-fresh libreoffice-fresh-ru --noconfirm

echo '>> Установка firefox'
pacman -Sy firefox firefox-i18n-ru flashplugin --noconfirm

#echo '>> Установка почтового клиента'
##pacman -Sy thunderbird thunderbird-i18n-ru --noconfirm

#echo '>> Разработка ПО'
##pacman -Sy qtcreator cmake kdevelop --noconfirm

#echo '>> VirtualBox'
##pacman -S virtualbox virtualbox-ext-vnc virtualbox-sdk virtualbox-guest-iso --noconfirm
#modprobe vboxdrv

#echo ">> Установка TeamViewer"
#aur teamviewer
#systemctl enable teamviewerd

echo '>> Читалки, просмотр фото, музыки и прочее'
echo '> Установка программ для обработки с музыки и видео'
#pacman -Sy vlc cheese --noconfirm
#pacman -Sy audacious --noconfirm #audacity --noconfirm
##pacman -Sy kdenlive --noconfirm

echo '> Установка программ для обработки графики'
##pacman -Sy gimp --noconfirm
#pacman  -Sy blender --noconfirm
#pacman -Sy gwenview --noconfirm

#echo '> Установка qbittorrent'
##pacman -Sy qbittorrent --noconfirm

#echo '>Прочее'
##pacman -Sy neofetch baobab okteta --noconfirm

#echo '>> Установка wine'
##pacman -Sy mono --noconfirm
##pacman -Sy wine wine-mono wine-gecko winetricks --noconfirm
#aur dxvk-bin
#winecfg
#setup_dxvk install
##pacman -Sy vkd3d lib32-vkd3d --noconfirm

echo '>> Ставим шрифты'
#pacman -Sy ttf-liberation ttf-dejavu --noconfirm
aur ttf-ms-fonts
aur ttf-tahoma

exit
