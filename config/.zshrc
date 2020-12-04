 # Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename "~/.zshrc"
autoload -Uz compinit
compinit

source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Android SDK
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

#eval "`dircolors -b $HOME/.lscolors`"

# Alias
alias ls="ls --color=auto"

if [ -f /usr/bin/grc ]; then
	alias gcc="grc --colour=auto gcc"
	alias irclog="grc --colour=auto irclog"
	alias log="grc --colour=auto log"
	alias netstat="grc --colour=auto netstat"
	alias ping="grc --colour=auto ping"
	alias proftpd="grc --colour=auto proftpd"
	alias traceroute="grc --colour=auto traceroute"
fi

alias yu="sudo pacman -Syu"
alias yyu="sudo pacman -Syyu"
alias ayu="pacaur -Syu"
alias pmc="sudo pacman -Rsnc \$(pacman -Qdtq)"

alias mkl="sudo mkinitcpio -p linux"
alias mklts="sudo mkinitcpio -p linux-lts"

alias key-add="gpg --keyserver keys.gnupg.net --recv-keys"
alias key-update="sudo pacman-key --populate archlinux"
# Functions
# Справка
function help() {
	echo -e "\033[34m    Алиасы"
	echo -e "\033[32mmkl, mklts \033[0m- \033[33mСобрать ядро linux и linux-lts"
	echo -e "\t\033[34msudo mkinitcpio \033[0m-p linux'"
	echo -e "\t\033[34msudo mkinitcpio \033[0m-p linux-lts"
	echo -e "\033[32myu, yyu    \033[0m- \033[33mОбновить пакеты"
	echo -e "\t\033[34msudo pacman \033[0m-Syu"
	echo -e "\t\033[34msudo pacman \033[0m-Syyu"
	echo -e "\033[32mayu        \033[0m- \033[33mОбновить пакеты, включая из AUR"
	echo -e "\t\033[34mpacaur -Syu"
	echo -e "\033[32mpmc        \033[0m- \033[33mУдалить ненужные пакеты"
	echo -e "\t\033[34msudo pacman \033[0m-Rsnc \$(\033[34mpacman \033[0m-Qdtq)"
	echo -e "\033[32mkey-add    \033[0m- \033[33mДобавить ключ"
	echo -e "\t\033[34mgpg \033[0m--keyserver keys.gnupg.net --recv-keys"
	echo -e "\033[32mkey-update \033[0m- \033[33mОбновить связку ключей"
	echo -e "\t\033[34msudo pacman-key \033[0m--populate archlinux"
	echo -e "\n\033[34m    Функции"
	echo -e "\033[32maur \033[0m- \033[33mУстановка из aur"
	echo -e "\033[32mex  \033[0m- \033[33mРаспаковать архив"
	echo -e "\033[32mpk  \033[0m- \033[33mСоздать архив"
}


# Установка из aur
# $1 наименование пакета
function aur {
	cd /tmp
	git clone https://aur.archlinux.org/$1.git
	cd $1
	makepkg -si
	cd ..
	rm -rf $1
}

# Распаковать архив
# $1 архив
function ex () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2) tar xvjf $1                              ;;
			*.tar.gz)  tar xvzf $1                              ;;
			*.tar.xz)  tar xvfJ $1                              ;;
			*.tar.zst) tar --extract --verbose --zstd --file=$1 ;;
			*.bz2)     bunzip2 $1                               ;;
			*.rar)     unrar x $1                               ;;
			*.gz)      gunzip $1                                ;;
			*.tar)     tar xvf $1                               ;;
			*.tbz2)    tar xvjf $1                              ;;
			*.tgz)     tar xvzf $1                              ;;
			*.zip)     unzip $1                                 ;;
			*.Z)       uncompress $1                            ;;
			*.7z)      7z x $1                                  ;;
			*)         echo "'$1' Не может быть распакован при помощи ex" ;;
		esac
	else
		echo "'$1' не является допустимым файлом"
	fi
}
# Создать архив
# $1 тип архива
# $2 каталог
function pk () {
	if [ $1 ] ; then
			case $1 in
			tbz) tar cjvf $2.tar.bz2 $2                                        ;;
			tgz) tar czvf $2.tar.gz  $2                                        ;;
			tar) tar cpvf $2.tar $2                                            ;;
			zst) tar --create --verbose --zstd --file=$2.tar.zst --add-file=$2 ;;
			bz2) bzip $2                                                       ;;
			gz)  gzip -c -9 -n $2 > $2.gz                                      ;;
			zip) zip -r $2.zip $2                                              ;;
			7z)  7z a $2.7z $2                                                 ;;
			*)   echo "'$1' не может быть упакован с помощью pk" ;;
		esac
	else
		echo "'$1' не является допустимым файлом"
	fi
}
