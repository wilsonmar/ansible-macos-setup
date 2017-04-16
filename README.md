This repo is used to setup software on a new OS X laptop for web development
by running a script that retrieves from this GitHub repository.

1. On an existing Mac, clone this repo and view the <strong>install.sh</strong> file.

   It installs xcode and homebrew because Ansible is installed using Homebrew.

   The script skips over apps already installed.

2. Edit <a href="#Playbook">playbook.yml (described below</a>)</a> and add/remove the apps/utils you want Ansible to install:

   <pre>
   vi playbook.yml
   </pre>

   Alternately, instead of vi, use another text editor such as atom, code, etc.

3. CAUTION: Do not run this on a Mac you've already configured (used for a while). 
   Create a virtual memory instance of a Mac to run this.

   You shouldn't wipe your entire workstation and start from scratch just to test changes to the playbook. 

   Instead, you can follow theses instructions for [how to build a Mac OS X VirtualBox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm), on which you can continually run and re-run this playbook to test changes and make sure things work correctly.

4. In a Terminal of a brand-new Mac (after operating system installation)
   run the install.sh bootstrap command to install the default list of tools and apps defined:

   <pre><strong>sh -c "$(curl -fsSL https://raw.githubusercontent.com/wilsonmar/ansible-macos-setup/master/install.sh)"
   </strong></pre>

   This runs 

   This was test run on OS X Sierra (~10.10.4).

5. Stop the script (by pressing Ctrl+C) when Ansible asks for the a 'sudo' password. 

   <pre>
   Changing to laptop repo dir ...
   &nbsp;
   Running ansible playbook ...
   SUDO password:  ^c
   </pre>

6. Change into the cloned repo dir

   <pre><strong>cd laptop</strong></pre>

7. Kick off Ansible manually to process based on its playbook.yml file:

   <pre><strong>ansible-playbook playbook.yml -i hosts --ask-sudo-pass -vvvv 
   </strong></pre>


   ### Change configuration

   This can be safely re-run several times after changing the configuration.
   The script uses Ansible, which is designed to be run several times on the same machine. 
   It installs, upgrades, or skips packages based on what is already installed on the machine.

8. Edit the file <strong>playbook.yml</strong> to change what is installed.

9. Add a comment signal <strong>#</strong> (or remove it).

   Under <strong>Applications:</strong> are apps installed by Homebrew Cask.

<hr />

<a name="Playbook"></a>

## Playbook.yml applications specified

UI Applications installed using Homebrew Cask:

  - 1password
  - alfred # | http://www.alfredapp.com 
  - apptrap # remove associated prefs when uninstalling
  - appzapper # uninstaller
  - bettertouchtool # window snapping. (maybe Moom is more lightweight?)
  - carbon-copy-cloner # backups | https://bombich.com/download
  - cheatsheet # know your shortcuts
  - cyberduck # ftp, s3, openstack
  - dash # totally sick API browser
  - diffmerge # free visual diq
  - disk-inventory-x # reclaim space on your expensive-ass Apple SSD | http://www.derlien.com/
  - dropbox # a worse Mega Sync
  - firefox 
  - flux # get more sleep
  - google-chrome
  - imageoptim # optimize images
  - istumbler # network discovery GUI
  - jumpcut # awesome clipboard
  - karabiner # Keyboard customization
  - licecap # GIFs !
  - little-snitch # awesome outbound firewall
  - megasync # a better Dropbox  
  - monolingual # remove unneeded osx lang files
  - nvalt # fast note taking
  - qlcolorcode # quick look syntax highlighting
  - qlimagesize # quick look image dimensions
  - qlmarkdown # quick look .md files
  - qlstephen # quick look extension-less text files
  - rowanj-gitx # Awesome gitx fork.
  - sequel-pro # FREE SQL GUI!
  - shortcat # kill your mouse
  - shuttle # ssh management
  - skype # 
  - sublime-text3 # (experimental cask) | http://www.sublimetext.com/
  - thunderbird # email
  - tomighty # pomodoro
  - torbrowser # be the noise
  - transmission # torrents
  - tunnelblick # VPN
  - vagrant # | https://www.vagrantup.com/downloads.html
  - vagrant-manager # 
  - virtualbox # | https://www.virtualbox.org/
  - vlc 


   ### Packages install by Homebrew
 
   Listed alphabetically:

  - autoconf
  - autojump # quickly navigate from cmd line
  - bash # Bash 4
  - boot2docker # obsolete way for running docker on osx
  - brew-cask
  - coreutils # Install GNU core utilities (those that come with OS X are outdated)
  - cowsay # amazing
  - docker # | https://docs.docker.com/installation/mac/
  - findutils  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
  - git
  - go  # golang
  - gpg
  - hub # github
  - keybase # in alpha at time of writing.
  - mtr # better traceroute
  - node
  - npm
  - openssl
  - packer
  - postgresql # yes and nosql
  - python
  - rbenv # ruby. Just installs binaries - assumes you bring in the dotfiles.
  - readline
  - redis
  - rename # rename multiple files
  - rsync
  - ruby-build
  - sqlite # production rails DB
  - the_silver_searcher # fast ack-grep
  - tmux
  - vim
  - wget
  - zsh  # Z shell

   There are several more utils listed in the playbook.yml - simply uncomment them to include them in your install. 


### System Settings

It also installs a few useful system preferences/settings/tweaks with a toned-down verson of Matt Mueller's 
[OSX-for Hackers script](https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716). 

It does some reasonably gnarly stuff e.g.

  - hide spotlight icon
  - disable app Gate Keeper
  - change stand-by delay from 1hr to 12hrs. 
  - Set trackpad tracking rate.
  - Set mouse tracking rate.
  - and lots more...

so you need read it very carefully first. (see scripts/system_settings.sh)

TODO: moar sick settings with https://github.com/ryanmaclean/OSX-Post-Install-Script


### User Preferences

It then syncs your user prefs with dotfiles+rcm

It grabs the [thoughttbot/dotfiles](https://github.com/thoughtbot/dotfiles) repo, saves it in `~/src/thoughtbot/dotfiles` and symlinks it to ~/dotfiles. 

It then grabs [glennr/dotfiles](https://github.com/glennr/dotfiles) repo, saves it in `~/src/glennr/dotfiles` and symlinks it to ~/dotfiles-local

You probably want to change the `dotfile_repo_username` variable to match your github username :-)

It then runs rcup to initialize your dotfiles.



### MacStore Apps (WIP)

These apps only available via the App Store. (sigh)

TODO: Port bork : https://github.com/mattly/bork/blob/master/types/macstore.sh and do this automagically!

From Apple:
   - Pages
   - Keynote
   - Numbers

From others:
   - Microsoft Office (Word, PowerPoint, Excel, etc. 2016)
   - 1Password
   - Monosnap
   - Tweetbot
   - RadarScope
   - Pixelmator
   - Quick Resizer
   - DaisyDisk
   - Byword
   - Aperture


### Application Settings (WIP)

Keep your application settings in sync.

TODO: Add Mackup task


### Other 

- install fonts like a boss : http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

- TODO: Install [Sublime Package Manager](http://sublime.wbond.net/installation).
- ZSH tab/auto completion
- Powerline in tmux
- zsh-autosuggestions plugin
- zsh-history-substring-search plugin
- zsh-notify plugin


### Approach

We've tested it using an OSX 10.10 Vagrant/Virtualbox VM for developing & testing the Ansible scripts.

Simply spin up the Yosemite box in a VM, and have vagrant kick off the laptop setup.

### Whats included?

Nada. Well not much. The whole point is to test the process of getting our OSX dev machines from zero to hero. 

The Vagrant box we use is a [clean-ish install of OSX](https://github.com/timsutton/osx-vm-templates). However the setup notes above uses Packer, which installs Xcode CLI tools. This can't be automated in an actual test run, and needs user intervention to install.


### Test Setup

1. Get [Homebrew Cask](http://caskroom.io/)
    
        brew install caskroom/cask/brew-cask

1. Install [Vagrant](https://www.vagrantup.com/downloads) 

        brew cask install --appdir="/Applications" vagrant

1. Install VirtualBox;

        brew cask install --appdir="/Applications" virtualbox

1. cd into this project directory;

1. Run 

        vagrant init http://files.dryga.com/boxes/osx-yosemite-10.10.3.0.box;

1. The Vagrantfile should be ready as soon as Vagrant downloads the box;

1. Start VM 

        vagrant up

### Notes

* VirtualBox doesn't have Guest additions for Mac OS X, so you can't have shared folders. Instead you can use normal network shared folders.

* If you are rolling your own box with [the OSX VM template](https://github.com/timsutton/osx-vm-templates), this is the Packer config;

      ```
      packer build \
        -var iso_checksum=aaaabbbbbbcccccccdddddddddd \
        -var iso_url=../out/OSX_InstallESD_10.10.4_14E46.dmg \
        -var update_system=0 \
        -var autologin=true \
        template.json
      ```

## Author

[Glenn Roberts](http://glenn-roberts.com), 2015. 


## Credits

This project is based off the work of the following folks;

* Eduardo de Oliveira Hernandes' [ansible-macbook](https://github.com/eduardodeoh/ansible-macbook])
* Jeff Geerlings' [Mac Dev Ansible Playbook](https://github.com/geerlingguy/mac-dev-playbook)
* [Thoughtbot/laptop](https://github.com/thoughtbot/laptop) (boostrapping, dev tools)
* [OSX for Hackers](https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716) (awesome osx tweaks)
* [Mackup](https://github.com/lra/mackup)  (backup/restore App settings)

*See also*:

  - [Battleschool](http://spencer.gibb.us/blog/2014/02/03/introducing-battleschool) is a more general solution than what I've built here. (It may be a better option if you don't want to fork this repo and hack it for your own workstation...).
  - [osxc](https://github.com/osxc) is another more general solution, set up so you can fork the [xc-custom](https://github.com/osxc/xc-custom) repo and get your own local environment bootstrapped quickly.
  - [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks) was the original inspiration for this repository, but this project has since been completely rewritten.

