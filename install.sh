#!/bin/bash

username=$0
pass=$1

function aur {
	cd /tmp
	git clone https://aur.archlinux.org/$1.git
	chown -R $username:users /tmp/$1
	chown -R $username:users /tmp/$1/PKGBUILD
	cd $1
	( echo $pass ) | -u $username makepkg -si --noconfirm
	cd ..
	rm -rf $1
}

echo '--------------------------------------------------'
echo '|              Установка драйверов               |'
echo '--------------------------------------------------'

echo '>> Установка xorg, xorg-xinit и mesa'
pacman -Sy xorg-server xorg-xinit mesa --noconfirm

mkdir -p /etc/X11/xorg.conf.d
cd /etc/X11/xorg.conf.d/

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

## Установка nvidia для новых видеокарт
##pacman -Sy nvidia nvidia-utils lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia nvidia nvidia-prime nvidia-settings --noconfirm
#echo '>> Настрока DRM nVidia'
#sed -i 's/MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /g' /etc/mkinitcpio.conf
## Настроить nvidia на ноутбуках с использованием PRIME Render Offload
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/X11/20-nvidia.conf'
## После перезагрузки выполнить sudo nvidia-xconfig для настройки видеокары
## sudo nvidia-xconfig --prime необходимо для конфигурирования драйвера в совместимом режиме с картой intel

echo '>> Установка настройки сети'
pacman -Sy networkmanager --noconfirm #samba --noconfirm
systemctl enable NetworkManager

#echo '>> Bluetooth pulseaudio и alsa поддержка звука'
##pacman -Sy bluez bluez-utils bluedevil pulseaudio-bluetooth alsa-utils --noconfirm
#systemctl enable bluetooth.service

#echo '>> VirtualBox'
##pacman -S virtualbox virtualbox-ext-vnc virtualbox-sdk virtualbox-guest-iso --noconfirm
#modprobe vboxdrv

echo '>> QEMU'
echo '> Vertio'
sed -i 's/MODULES=(/MODULES=(virtio virtio_blk virtio_pci virtio_net /g' /etc/mkinitcpio.conf
echo '> Установить поддержку комманд QMP'
pacman -S qemu-guest-agent --noconfirm
systemctl enable qemu-guest-agent.service

echo '--------------------------------------------------'
echo '|           Установка Display Manager            |'
echo '--------------------------------------------------'
# раскомментировать блок SDDM или LigtDM

#echo '>> Установка gdm' # Рекомендуется только для гном
#pacman -Sy gdm --noconfirm
#systemctl enable gdm.service

#echo '>> Установка LightDM'
#pacman -Sy lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm
#cd /etc/lightdm/
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/lightdm/lightdm.conf'
#wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/lightdm/display_setup.sh'
#chmod +x display_setup.sh
#systemctl enable lightdm.service
#cd ~/

#echo '>> Установка lxdm'
#pacman -Sy lxdm --noconfirm
#systemctl enable lxdm.service

echo '>> Установка sddm'
pacman -Sy sddm sddm-kcm --noconfirm
systemctl enable sddm

echo '--------------------------------------------------'
echo '|         Установка Desktop Environment          |'
echo '--------------------------------------------------'
# Прежде чем продолжить желательно установить любой из базовых шрифтов gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation
pacman -Sy gnu-free-fonts --noconfirm

#echo '>> Gnome'
#pacman -Sy gnome gnome-shell gnome-extra --noconfirm

#echo '>> Cinnamon'
##pacman -Sy cinnamon cinnamon-translations --noconfirm
##pacman -Sy gnomme-terminal

#echo '>> Deepin'
##pacman -Sy deepin --noconfirm

echo '>> KDE Plasma'
pacman -Sy phonon-qt5-vlc --noconfirm
#Полная установка kde со всеми приложениями
#pacman -Sy plasma kde-accessibility kde-applications kde-education kde-games kde-graphics kde-multimedia kde-network kde-system kde-utilities kdepim kdesdk packagekit-qt5 --noconfirm

#Минимальная без приложений
pacman -Sy plasma-desktop plasma-nm plasma-pa breeze breeze-gtk kde-gtk-config --noconfirm
echo '>  Дополнительный софт для KDE'
pacman -Sy konsole ark spectacle okular kcalc --noconfirm
#pacman -Sy aspell aspell-ru --noconfirm

#echo '>> XFCE'
##pacman -Sy xfce4 xfce4-goodies --noconfirm

#echo '>> LXDE'
#pacman -Sy lxde --noconfirm
echo '--------------------------------------------------'
echo '|        Установка дополнительного софта         |'
echo '--------------------------------------------------'

echo '>> Настройка папок пользователя'
pacman -Sy xdg-user-dirs --noconfirm

#pacman -Syu
pacman -Sy git --noconfirm

echo '>> Установка библиотек для функция pk и ex'
pacman -Sy p7zip unrar unarchiver lzop lrzip --noconfirm

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

#echo '>> Установка менеджер дисков KDE'
#pacman -Sy partitionmanager --noconfirm

#echo '>> Установка Double Commander'
##pacman -S doublecmd-qt5 --noconfirm

#echo '>> Установка Firewall'
##pacman -Sy ufw gufw --noconfirm
#systemctl enable ufw.service

#echo '>> Установка LibreOffice'
##pacman -Sy libreoffice-fresh libreoffice-fresh-ru --noconfirm

echo '>> Установка firefox'
pacman -Sy firefox firefox-i18n-ru --noconfirm

#echo '>> Установка почтового клиента'
##pacman -Sy thunderbird thunderbird-i18n-ru --noconfirm

#echo '>> Разработка ПО'
##pacman -Sy qtcreator cmake --noconfirm

echo '>> Читалки, просмотр фото, музыки и прочее'
echo '> Установка программ для обработки с музыки и видео'
pacman -Sy vlc --noconfirm #cheese --noconfirm
pacman -Sy audacious --noconfirm #audacity --noconfirm
##pacman -Sy kdenlive --noconfirm

echo '> Установка программ для обработки графики'
##pacman -Sy gimp --noconfirm
#pacman  -Sy blender --noconfirm
pacman -Sy gwenview --noconfirm

#echo '> Установка qbittorrent'
##pacman -Sy qbittorrent --noconfirm

#echo '>Прочее'
##pacman -Sy neofetch baobab okteta --noconfirm

#echo '>> Установка wine' #требует поддержку x86.
##pacman -Sy mono --noconfirm
##pacman -Sy wine wine-mono wine-gecko winetricks --noconfirm
#aur dxvk-bin
#setup_dxvk install
##pacman -Sy vkd3d lib32-vkd3d --noconfirm

exit
