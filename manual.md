# install manual

## vim

- gcc
  - which gcc
  - yum install -y gcc

- ncurses-devel
  - yum install -y ncurses-devel

- lua
  - which lua
  - dnf --enablerepo=PowerTools install lua-devel

- ruby
  - which ruby
  - yum install -y ruby-devel

- python3
  - which python3
  - yum install -y python3-devel

- vim
  - install git
  - git clone https://github.com/vim/vim.git
  - cd vim
  - ./configure --with-features=huge --enable-multibyte --enable-luainterp=dynamic --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local --enable-python3interp=dynamic --enable-rubyinterp=dynamic
    - LDFLAGS="$LDFLAGS -fPIC" を入れてみる(--enable-rubyinterp=dynamicのため？)
  - sudo make
  - ./src/vim --version
  - yum remove vim-enhanced
  - which vim
  - make install
  - which vim
  - vim --version

## zsh
- which zsh
- yum install -y zsh
- chsh -s PATH/zsh (if no command chsh -> install util-linux-user)
- echo $SHELL

## zsh-completions
- git clone https://github.com/zsh-users/zsh-completions
- mv zsh-completions .zsh-completions

## neovim
- pip3 install neovim

## mycli
- pip3 install mycli

## tmux
- git clone https://github.com/tmux/tmux
- sh autogen.sh
- cd tmux
- sudo yum -y install libevent-devel  (if not install)
- ./configure
- make
- sudo make install
- tmux -V

## php
- sudo yum install epel-release
- sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
- sudo yum update
- sudo yum repolist
> - sudo yum -y install --enablerepo=epel,remi,remi-php73 php php-devel php-mbstring php-pdo php-mysqlnd php-gd php-xml php-mcrypt
>   - mysqlのドライバーをいれるため、php-mysqlndを追加した
- sudo dnf module install php:remi-7.4
- php -r "echo phpinfo();" | grep "php.ini"

## xdebug
- sudo dnf install php-pecl-xdebug
- vi /etc/php.d/15-xdebug.ini
  - xdebug.remote_autostart = true
  - xdebug.remote_connect_back = true
  - xdebug.remote_enable = true
  - xdebug.remote_port = 9001
- systemctl restart php-fpm

## zip unzip
- sudo yum install -y zip unzip

## SELinux
- getenforce
- sudo vi /etc/selinux/config
- SELINUX=enforcing -> disabled
- reboot

## composer
- php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
- php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  } echo PHP_EOL;"
- php composer-setup.php
- php -r "unlink('composer-setup.php');"
- mv composer.phar /usr/local/bin/composer

## nodeJS npm
- su -
- curl -sL https://rpm.nodesource.com/setup_10.x | bash -
- yum install nodejs
- node -v
- npm -v
- npm update -g

## dotfiles
- git clone https://github.com/k-syu0/dotfiles
- cd dotfiles
- ./link.sh

## mysql8
- yum localinstall -y https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
- install mysql
- install mysql-community-server
- systemctl start mysqld.service

### how to start up
- sudo cat /var/log/mysqld.log
- mysql -u root -p
- SET GLOBAL validate\_password.length = 8;
- SET GLOBAL validate\_password.policy = LOW;
- ALTER USER 'root'@'localhost' IDENTIFIED BY '12345678';
- SHOW VARIABLES LIKE 'validate\_password%';
- UNINSTALL COMPONENT 'file://component\_validate\_password';
- create user dbuser@localhost;
- grant all on \*.\* to dbuser@localhost;
- show variables like 'default_authentication_plugin';
  - デフォルトのユーザー認証のプラグインの確認
  - mysql8からは、「caching_sha2_password」となっている
- select user, plugin from mysql.user;
- alter user 'dbuser'@'localhost' identified with mysql_native_password by '';
  - phpのpdoでは、まだ「caching_sha2_password」に対応していないため、もともと使われていた「mysql_native_password」に変更
- INSTALL COMPONENT 'file://component\_validate\_password';

## centos
- version確認
  - cat /etc/redhat-release
- lsのdirの色設定
  - sudo cp /etc/DIR\_COLORS ~/.dir\_colors
  - vim .dir\_colos
  - eval 'dircolors .dir\_colors -b'
- timezone
  - timedatectl status
  - sudo timedatectl set-timezone Asia/Tokyo
- locale
  - localectl status
  - localectl list-locales | grep US
  - sudo localectl set-locale LANG=en_US.utf8
  - source /etc/locale.conf
  - エラーの場所は以下を確認
    - locale -a | grep ~
    - ない場合は以下
      - sudo localedef -f UTF-8 -i en_US en_US
      - source /etc/locale.conf
    - 以下のコマンドでリセットされる
      - sudo yum update glibc-common
- service
  - systemctl list-jobs
  - systemctl list-unit-files --type=service

## vagrant
- SSL証明書error
  - vim Vagrantfile
  - config.vm.box\_download\_insecure = true

## apache
- Require all granted
  - 全てのアクセスを許可
  - 特定のipを許可・拒否出来る
- AllowOverRide All
  - .htaccessがある場合
- FollowSymLinks
  - シンボリックリンクのリンク先を Apache がたどれるようにする

## laravel
- php artisan key:generate
  - APP_KEYの値が生成され、.envファイルに追加される
  - composerでインストールすれば自動的に実行される
