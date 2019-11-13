# arch-install
Скрипт установки Arch linux (для опытных пользователей)
Данный скрипт для разворачивания системы одной командой

## 1. Загрузка скрипта
Загрузить скрипт командой
```bash
wget get.io/wget-arch-install
sh wget-arch-install
```
В результате загрузятся 3 скрипта
```bash
install #Подгатовка к установке Arch-Linux
chroot  #Установка Arch и драйверов и дополнительных программ
ru.sh   #Руссификация консоли
```
## 2. Настройка скриптов
Прежде чем приступить к настройке необходимо руссифицировать Arch выполните команду
```bash
./ru.sh
```
Вся дальнейшая настройка выполняется редактированием файлов **install** и **chroot**
Настройка имени пользователя и пароля вынесено в начало скрипта **install**
```bash
echo '--------------------------------------------------'
echo '|                Config Install                  |'
echo '--------------------------------------------------'
username="user"
hostname="HOST"
```
Замените *user* и *HOST* на имя пользователя и имя компьютера соответственно

## 3. Установка
Запустите скрипт **install**
```bash
./install
```
