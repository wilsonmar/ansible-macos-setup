#!/bin/sh

# File osx-new-bash-script.sh
# based on https://github.com/sobolevn/dotfiles/blob/master/Brewfile
# Let me know you're using this - wilsonmar@gmail.com

# After running https://github.com/wilsonmar/ansible-macos-setup
# To run this, open a Terminal window and manually:
#   chmod +x osx-new-bash-script.md
# XCode > Homebrew > git > ruby, node > npm > apm

# TODO:
# - bring in my_secrets file
# - create ssh files
# - create .bash_profile

# brew installs to /usr/local/Cellar/...

fancy_echo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\n>>> $fmt\n" "$@"
}

#if [[ $EUID -ne 0 ]]; then
#   echo “Run using sudo "$0" to avoid repeat entry of passwords.“ 1>&2
#   exit 1
#fi

fancy_echo "Boostrapping ..."
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
#set -e
#set -o xtrace  # for debugging this bash shell script.


# From https://gist.github.com/somebox/6b00f47451956c1af6b4
function echo_ok { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error  { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }


# Ensure Apple's command line tools (such as cc) are installed:
if ! command -v cc >/dev/null; then
  fancy_echo "Installing Apple's xcode command line tools ..."
  xcode-select --install 
else
  fancy_echo "Xcode already installed. Skipping."
fi


## Networking
# See https://serverfault.com/questions/102416/iptables-equivalent-for-mac-os-x
# WaterRoof or Flying Buttress to iptables


## ~/.bash_profile
# Add $PATH
# TODO: Check if file is present: ~/.bash_profile
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#fancy_echo "Brew Doctor before starting ..."
#brew doctor

fancy_echo "Configre Terminal to show all files:"
defaults write com.apple.finder AppleShowAllFiles YES

# TODO: Define proxy:
# See https://www.predix.io/resources/tutorials/tutorial-details.html?tutorial_id=1565

## For support:
# See http://macappstore.org/real-vnc/ 
# and https://www.realvnc.com/en/connect/download/viewer/
# brew cask install real-vnc
# (no uninstaller)


# brew cask install git
brew cask install sourcetree

# fancy_echo "Installing Bluetooth ..."
# 0. Check "Show Bluetooth in menu bar".

## Battery percentage
# http://osxdaily.com/2016/12/13/see-battery-life-remaining-macos-sierra/

#fancy_echo "Installing Bash 4 ..."
#brew install -g bash
   # In order to use this build of bash as your login shell,
   # it must be added to /etc/shells.

fancy_echo "Installing basic Linux utilities ..."
brew cask install iterm2
brew install -g wget
brew install -g tree
brew install -g htop

# https://github.com/caskroom/homebrew-cask/blob/master/Casks/the-unarchiver.rb
# brew cask install the-unarchiver  

fancy_echo "GNU utilities to sign ..."
#brew install -g gpg # https://geoff.greer.fm/ag/
#brew install -g gpg1
#brew install -g pinentry-mac
brew install -g openssl
    # openssl version  # OpenSSL 0.9.8zh 14 Jan 2016
#brew install -g gnu-sed # sed -i s/your-bucket-name/$DEVSHELL_PROJECT_ID/ config.py


## Install GNU core utilities (those that come with OS X are outdated)
# brew tap homebrew/dupes
brew install -g coreutils
#brew install -g gnu-sed --with-default-names
#brew install -g gnu-tar --with-default-names
#brew install -g gnu-indent --with-default-names
#brew install -g gnu-which --with-default-names
#brew install -g gnu-grep --with-default-names

#brew install -g findutils  --with-default-names

# To analyze network traffic and files (from https://www.wireshark.org/)
#brew install wireshark
#brew cask install wireshark
    # password required here.

# fancy_echo "Installing File transfer:"
#brew cask install filezilla  ## config file too???
   # TODO: Download Filezilla config file.
   
# fancy_echo "Installing Cloud File Strage apps:"
# TODO: brew cask install box
# brew cask install dropbox
# brew cask install google drive (backup and sync) ???
# Amazon Drive storage
# dattodrive free storage
# brew cask install transmission. # Bittorrant https://transmissionbt.com/

# Compare text files:
brew cask install p4merge 
# kdiff3 # https://www.slant.co/options/4399/alternatives/~kdiff3-alternatives


#brew cask install java
   java -version

brew install -g maven
    mvn -v
brew install -g gradle
    # gradle --version

brew install -g yarn --ignore-dependencies
    # 1.3.2

# brew install -g carthage # to build  https://github.com/Carthage/Carthageexit 9 


brew install -g bower  # installer for GUI

brew install -g grunt-cli

brew install -g http-server
#brew install -g express
# from Walmart Labs

#brew install -g nativescript # https://www.nativescript.org/blog/installing-nativescript-on-windows

#brew install -g python
   # python -V  # 2.7
brew install -g python3
#pip install --upgrade flake8

#virtualenv
brew cask install anaconda
   # To use anaconda, add the /usr/local/anaconda3/bin directory to your PATH environment 
   # variable, eg (for bash shell):
  export PATH=/usr/local/anaconda3/bin:"$PATH"
#brew doctor fails run here due to /usr/local/anaconda3/bin/curl-config, etc.
#Cask anaconda installs files under "/usr/local". The presence of such
#files can cause warnings when running "brew doctor", which is considered
#to be a bug in Homebrew-Cask.

# Using Python - # see https://djangoforbeginners.com/
pip3 install jupyter  

# TODO: Ruby comes with MacOS:
#brew install -g ruby
ruby -v  # ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-darwin16]

#fancy_echo "Installing Mac Productivity …:"
#brew cask install alfred  # https://www.alfredapp.com/
  
# brew install -g the_silver_searcher. # https://github.com/ggreer/the_silver_searcher


if ! command -v node >/dev/null; then
    fancy_echo "node and npm ..."
    brew install -g node
else
    node -v  #v9.5.0
fi

if ! command -v npm >/dev/null; then
   brew install -g npm  # node package manager 
else
    npm -v # 5.6.0
fi
#npm install --global nodemon -g
#npm install --global gulp-cli  #https://www.taniarascia.com/getting-started-with-gulp/
#npm  # https://gist.github.com/codeinthehole/26b37efa67041e1307db



## Notes and secrets:
# http://mike.kaply.com
# is a goldmine for configuring Firefox by the author of CCK and CCK2
#https://stackoverflow.com/questions/37728865/install-webextensions-on-firefox-from-the-command-line
#AgileBits
brew cask install 1password
# brew install lastpass-cli
# brew cask install keepassx

brew cask install kindle
brew cask install evernote

fancy_echo "Installing Text Editors & IDEs:"
brew cask install sublime-text
brew cask install atom
    # apm upgrade -c false  # (atom package manager) https://github.com/atom/apm

# bbedit
brew cask install visual-studio-code
# https://docs.microsoft.com/en-us/visualstudio/mac/installation
# brew cask install microsoft-office # Office 2016 installer

brew cask install macvim  # See https://github.com/macvim-dev/macvim 
   # vimtutor

brew cask install intellij-idea-ce

brew cask install sts
# brew cask install eclipse-java  # Not STS
   # android-studio from mobile dev ???

brew cask install adobe-acrobat-reader

#brew cask install viscosity  # OpenVPN client http://www.sparklabs.com/viscosity/


#fancy_echo "Installing hardware location in case of theft:"
# TODO: Enter API key from the bottom-left corner of the Prey web account Settings page:
#HOMEBREW_NO_ENV_FILTERING=1 API_KEY="abcdef123456" brew cask install prey
#brew cask install prey  # to track your mobile devices and laptops


#fancy_echo "Installing Mobile dev:"
#brew install android-sdk
#0. Update the sdk if needed through
#    android update sdk --no-ui
#0. Install NDK (for IL2CPP)
#   https://developer.android.com/ndk/downloads/index.html
#0. Add android-sdk to Unity
#   Unity > Preferences > External Tools > Android, SDK : Browse

#   SHIFT+CMD+G
#   Enter path /usr/local/Cellar/android-sdk/

#fancy_echo "Installing Unity VR dev:"
#1. Create a Unity ID.
#https://github.com/wooga/homebrew-unityversions
#0. Download Unity Editor:
#http://unity3d.com/unity/download/?_ga=2.194647725.1237052200.1507160407-416598928.1507160407
#Alternately, UnityDownloadAssistant-2017.1.1f1.dmg
#2. To install/upgrade Unity3d on a remote mac OS X machine and you only have shell access:
 #  $ alias wget="curl -O -L"
 #  $ wget http://download.unity3d.com/download_unity/unity-3.5.0.dmg
 #  $ hdiutil mount unity-3.5.0.dmg

#3. Script to install:
   # https://bitbucket.org/WeWantToKnow/unity3d_scripts


# see https://wilsonmar.github.io/rdp
# manual download https://rink.hockeyapp.net/apps/5e0c144289a51fca2d3bfa39ce7f2b06/ as of 20 FEB 2018.
    # MD5: B2A14013DE628BDEEBD6CEA395CE5066 


#https://www.eternalstorms.at/yoink/Yoink_-_Simplify_and_Improve_Drag_and_Drop_on_your_Mac/Yoink_-_Simplify_drag_and_drop_on_your_Mac.html

if ! command -v docker >/dev/null; then
    fancy_echo "Installing Docker (xhyve):"
    brew cask install --appdir="/Applications" virtualbox
    brew cask install --appdir="/Applications" vagrant
    brew cask install --appdir="/Applications" easyfind

    # https://pilsniak.com/how-to-install-docker-on-mac-os-using-brew/
    brew install -g docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
    sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
else
    docker -v  # Docker version 18.02.0-ce, build fc4de44
fi

# Browsers:
# /Applications/Google Chrome.app
#brew cask install --appdir="/Applications" google-chrome

#brew cask install --appdir="/Applications" firefox
brew cask install brave  # browser

brew cask install flash-player  # https://github.com/caskroom/homebrew-cask/blob/master/Casks/flash-player.rb
brew cask install adobe-air
# DISCONTINUED: brew cask install google-notifier
brew cask install silverlight

brew cask install flux  # yellow screen at night to minimize blue light before sleep.

fancy_echo "Installing Collaboration / screen sharing:"
#https://zapier.com/blog/disable-mic-webcam-notifications/
brew cask install skype  # unselect show birthdays
#brew cask install skype-for-business  # unselect show birthdays
brew cask install slack
brew cask install google-hangouts
brew cask install sococo
brew cask install zoom
brew cask install whatsapp
brew cask install teamviewer
# GONE? brew cask install Colloquy. ## IRC http://colloquy.info/downloads.html
#brew cask install hipchat
#brew cask install joinme
# GONE: brew cask install gotomeeting
# blue jeans? (used by ATT)

# brew cask install webex-nbr-player  # had error.
# So Download webexplayer_intel.dmg http://macappstore.org/webex-nbr-player/
# curl https://welcome.webex.com/client/T31L/mac/intel/webexnbrplayer_intel.dmg

#mutemymikefree
#Textual from Appstore


## fancy_echo "Installing Music apps :"
# brew cask install pandora-one
# brew cask install amazon-music
# brew cask install lastfm



## Fonts:
#https://www.fontsquirrel.com/fonts/open-sans
#Copy them into /Library/Fonts (for system wide use) or ~/Library/Fonts (for use by current user).


# download: VMware fusion
#brew install -g opencv
#brew install -g tesseract

# Install $30 Mac app Waltr (from Softorino) to convert media files and transfer them to iPhones/iPads
# See https://www.macworld.com/article/2863171/waltr-converts-and-copies-just-about-any-media-file-to-your-iphone-and-ipad.html

brew cask install imageoptim  # shrink image files.
#brew cask install omnigraffle

#fancy_echo "Installing Camtasia for video capture and editing:"
Brew cask install camtasia

# brew cask install creativecloud
# brew cask install adobe-creative-cloud
# brew cask install google-earth
# brew install youtube-dl
# brew cask install vlc   # mp4 video file viewer.

## Gaming
# brew cask install steam  # http://macappstore.org/steam/

## Devops:
# brew install -g ansible
# brew install -g ansible-lint
# brew install -g kubeadm kubectl kubelet kubernetes-cni
# brew of apt-get install docker.io kubeadm kubectl


#fancy_echo "Installing Jekyll static website tools:"
#brew install -g grip.  # https://github.com/joeyespo/grip
# GONE: brew install -g jekyll


fancy_echo "Installing RabbitMQ:"
brew install rabbitmq
#MONGO_HOST=  Host where MongoDB is running
#MONGO_PORT=  Port where MongoDB is listening for requests

fancy_echo "Installing MongoDB database:"
brew install mongodb 
# AMQP_HOST= Host where RabbitMQ is running
# AMQP_PORT= Port where RabbitMQ is listening for requests

# If servers are not in the hosts file, add it:
if ! grep mongodb "/etc/hosts"; then
    # Add -q after grep to display string found.
    fancy_echo "Appending MongoDB to hosts file (password required) ..."
    sudo -- sh -c "echo 127.0.0.1 mongodb >> /etc/hosts"
    # sudo -- spawns a new host to do it.
fi
if ! grep rabbitmq "/etc/hosts"; then
    fancy_echo "Appending rabbitmq to hosts file (password required) ..."
    sudo -- sh -c "echo 127.0.0.1 rabbitmq >> /etc/hosts"
fi
    # sudo -- sh -c -e "echo '192.34.0.03   subdomain.domain.com' >> /etc/hosts";
fancy_echo "Verify resulting contents of /etc/hosts file:"
cat /etc/hosts   # 


#fancy_echo "Installing MySQL database:"
# NO —client-only /// brew install mysql --client-only
#mongoldb
#To have launchd start mongodb now and restart at login:
#  brew services start mongodb
#Or, if you don't want/need a background service you can just run:
#  mongod --config /usr/local/etc/mongod.conf
#==> Summary
#🍺  /usr/local/Cellar/mongodb/3.4.9: 19 files, 284.9MB

#brew cask install mysql-workbench
#brew cask install mysqlworkbench


brew install tomcat
   #To have launchd start tomcat now and restart at login:
   #brew services start tomcat
   #Or, if you don't want/need a background service you can just run:
   # catalina run

pwd

if [ ! -f "/Applications/Postman.app" ]; then
    fancy_echo "Downloads Postman for REST API dev ..."
#    wget -o Postman-osx-latest.zip https://dl.pstmn.io/download/latest/osx ~/Downloads 
#    unzip -q ~/Downloads/Postman-osx-latest.zip 
#    mv ~/Downloads/Postman.app /Applications/
#    pwd
fi

# Functional Testing:
#sikulix with opencv and selenium
#protractor
#kafka

# Performance testing:
#brew cask install JProfiler # https://www.ej-technologies.com/download/jprofiler/files

brew install jmeter --with-plugins  # all plugins
    #open /usr/local/bin/jmeter



fancy_echo "Cloud Foundary CLI:"
brew install cloudfoundry/tap/cf-cli
    # See https://github.com/cloudfoundry/cli#installing-using-a-package-manager

fancy_echo "Google Cloud SDK: (python 2.7)"
brew tap caskroom/cask
brew cask install google-cloud-sdk

#brew install -g azure-cli  # https://docs.microsoft.com/cli/azure/overview
#brew cask install heroku-toolbelt
#pip install awscli



#https://github.com/so-fancy/diff-so-fancy



## Others

#I do not recommend indescrimately adding software.
#Not only do you waste disk space on tools you never use, you slow down your other work, and can open your #computer up to being hacked:

#brew install -g fish
#brew install -g calc
#brew install -g ncdu
#brew install -g irssi

#brew cask install flowdock
#brew cask install fuze
#brew cask install ghostpath
#brew cask install omnifocus
#brew cask install parallels
#brew cask install SubnetCalc
#brew cask install disk-inventory-x
#brew cask install hosts

#brew cask install adium
#brew cask install mailplane
#brew cask install cyberduck

#brew install watch
#brew install mobile-shell
#brew install graphicsmagick
#brew install unrar

#brew cask install backblaze
#brew cask install charles
#brew cask install flowdock
#brew cask install ghostpath
#brew cask install keepassx
#brew cask install omnifocus
#brew cask install parallels
#brew cask install SubnetCalc

#brew cask install disk-inventory-x

#brew cask install jumpcut # clipboard
#brew cask install karabiner # Keyboard customization
#brew cask install rowanj-gitx # Awesome gitx fork.
#brew cask install shortcat # kill your mouse

#brew cask install --appdir="/Applications" charles # proxy
#brew cask install --appdir="/Applications" easyfind
#brew cask install --appdir="/Applications" github
#brew cask install --appdir="/Applications" jdownloader


#https://gist.github.com/arctouch-shadowroldan/279d90d2fe414d1bbe02

#http://osxdaily.com/2017/05/30/big-mac-annoyances-fix-them/

#https://gist.github.com/codeinthehole/26b37efa67041e1307db

#https://github.com/fcoury/install

#http://www.vreference.com/2016/05/05/mac-os-x-application-installation-automation/

#https://github.com/ferventcoder/chef-chocolatey-presentation

fancy_echo "To manage Mac apps: see https://github.com/mas-cli/mas"
brew install mas
    #mas signin --dialog mas@example.com
    # mas install 808809998 # Apps must already be in the Purchased tab of the App Store.
    # quip
    # microsoft office
    mas list

# Apps are stored in the "/Applications" folder.

############## Wrap-up:

fancy_echo "Listing of all brews installed (including dependencies automatically added):"
# brew list
ls ~/Library/Caches/Homebrew

fancy_echo "Listing of all brew cask installed (including dependencies automatically added):"
brew info --all

#brew doctor
brew cleanup
brew cask cleanup

fancy_echo “DONE”
