class d4k::workshop_tinkerforge_electricity {

  package { ['openjdk-8-jdk', 'maven', 'libusb-1.0-0', 'libudev0', 'pm-utils', 'python', 'python-qt4',
    'python-qt4-gl', 'python-opengl', 'python-serial']:
    ensure          => installed,
    install_options => ['--allow-unauthenticated', '-f'],
  }

  package { 'openjdk-7-jdk':
    ensure => "purged"
  }

  exec { 'download brick-daemon':
    command => '/usr/bin/wget http://download.tinkerforge.com/tools/brickd/linux/brickd_linux_latest_armhf.deb',
    cwd     => '/home/pi/Downloads',
    creates => '/home/pi/Downloads/brickd_linux_latest_armhf.deb',
    user    => 'pi',
  } ->
  package { 'install brick-daemon':
    ensure    => installed,
    provider  => dpkg,
    source    => '/home/pi/Downloads/brickd_linux_latest_armhf.deb',
  }

  exec { 'download brick-viewer':
    command => '/usr/bin/wget http://download.tinkerforge.com/tools/brickv/linux/brickv_linux_latest.deb',
    cwd     => '/home/pi/Downloads',
    creates => '/home/pi/Downloads/brickv_linux_latest.deb',
    user    => 'pi',
  } ->
  package { 'install brick-viewer':
    ensure    => installed,
    provider  => dpkg,
    source    => '/home/pi/Downloads/brickv_linux_latest.deb',
  }

  vcsrepo { '/home/pi/workshops/workshop-tinkerforge-strom':
    ensure   => present,
    provider => git,
    source   => 'git@192.168.1.100:workshop-tinkerforge-strom',
    revision => 'master',
    user     => 'pi',
  }
}
