class d4k::client {
  $packages = ['gedit', 'iceweasel', 'wget', 'git', 'vim', 'htop', 'wpagui']

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
    content => template('d4k/interfaces.erb'),
  }
  file { '/etc/wpa_supplicant/wpa_supplicant.conf':
    ensure => present,
    source => "puppet:///modules/${module_name}/wpa_supplicant.conf",
  }
  file { '/etc/wpa_supplicant/wpa_supplicant1.conf':
    ensure => present,
    source => "puppet:///modules/${module_name}/wpa_supplicant1.conf",
  }
  file { '/home/pi/Desktop/wpa_gui_wlan1.sh':
    ensure => present,
    source => "puppet:///modules/${module_name}/wpa_gui_wlan1.sh",
    owner  => 'pi',
    group  => 'pi',
    mode   => '0755',
  }

  file { '/usr/share/images/desktop-base/devoxx4kids_wallpaper.png':
    ensure => present,
    source => "puppet:///modules/${module_name}/devoxx4kids_wallpaper.png",
  } ->
  exec { 'change desktop background wallpaper':
    command => '/usr/bin/pcmanfm -w /usr/share/images/desktop-base/devoxx4kids_wallpaper.png --wallpaper-mode=center',
  } ->
  exec { 'change desktop background color':
    command => 'sed -i "s/^desktop_bg=.*/desktop_bg=#ffffff/" ~/.config/pcmanfm/LXDE-pi/desktop-items-0.conf',
  }

  class { 'keyboard':
    layout => 'de',
  }

  file { '/home/pi/setup.sh':
    ensure => present,
    source => "puppet:///modules/${module_name}/setup.sh",
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
  } ->
  file { '/home/pi/.ssh/authorized_keys':
    ensure => present,
    source => "puppet:///modules/${module_name}/authorized_keys",
    owner  => 'pi',
    group  => 'pi',
    mode   => '0600',
  }

  file { '/etc/systemd/system/default.target':
    ensure => 'link',
    target => '/lib/systemd/system/graphical.target',
  }

  file_line { 'set graphical ram to 256MB':
    path  => '/boot/config.txt',
    line  => 'gpu_mem=256',
    match => 'gpu_mem=',
  }
}