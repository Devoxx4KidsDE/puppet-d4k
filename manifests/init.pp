class client (){
  $packages = ['gedit', 'iceweasel', 'wget', 'git', 'vim', 'htop']

  exec { 'apt-get-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
  } ->
  package { $packages:
    ensure          => installed,
    install_options => ['--allow-unauthenticated', '-f'],
  }

  file { '/etc/network/interfaces':
    ensure  => present,
    content => template('client/interfaces.erb'),
  } ->
  file { '/etc/wpa_supplicant/wpa_supplicant.conf':
    ensure => present,
    source => "puppet:///modules/${module_name}/wpa_supplicant.conf",
  }

  file { '/usr/share/backgrounds/':
    ensure => 'directory',
    mode   => '0751',
  } ->
  file { '/usr/share/backgrounds/devoxx4kids_wallpaper.png':
    ensure => present,
    source => "puppet:///modules/${module_name}/devoxx4kids_wallpaper.png",
  } ->
  file { '/etc/alternatives/desktop-background':
    ensure => 'link',
    target => '/usr/share/backgrounds/devoxx4kids_wallpaper.png',
  }

  class { 'keyboard':
    layout => 'de',
  }

  file { '/home/pi/change_hostname.sh':
    ensure => present,
    source => "puppet:///modules/${module_name}/change_hostname.sh",
    owner  => 'pi',
    group  => 'pi',
    mode   => '0755',
  }

  file { '/home/pi/add_puppet_master.sh':
    ensure => present,
    source => "puppet:///modules/${module_name}/add_puppet_master.sh",
    owner  => 'pi',
    group  => 'pi',
    mode   => '0755',
  }

  file { '/home/pi/.bashrc':
    ensure => present,
    source => "puppet:///modules/${module_name}/.bashrc",
    owner  => 'pi',
    group  => 'pi',
    mode   => '0644',
  }

  file { '/home/pi/workshops':
    ensure => 'directory',
    owner  => 'pi',
    group  => 'pi',
    mode   => '0751',
  }

  ssh::resource::known_hosts { 'pi':
    hosts => '192.168.1.100',
    user  => 'pi',
  } ->
  file { '/home/pi/.ssh/id_rsa':
    ensure => present,
    source => "puppet:///modules/${module_name}/id_rsa",
    owner  => 'pi',
    group  => 'pi',
    mode   => '0600',
  } ->
  file { '/home/pi/.ssh/id_rsa.pub':
    ensure => present,
    source => "puppet:///modules/${module_name}/id_rsa.pub",
    owner  => 'pi',
    group  => 'pi',
  }

  class { 'resolv_conf':
    nameservers => ['192.168.1.1', '8.8.8.8'],
  }

  file { '/etc/systemd/system/default.target':
    ensure => 'link',
    target => '/lib/systemd/system/graphical.target',
  }
}