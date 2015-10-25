class d4k::workshop_maze_vr {

  package { 'curl':
    ensure          => installed,
    install_options => ['--allow-unauthenticated', '-f'],
  } ->
  exec { 'setup node':
    command => '/usr/bin/curl --silent --location https://deb.nodesource.com/setup_4.x | bash -',
    creates => '/etc/apt/sources.list.d/nodesource.list'
  } ->
  package { 'nodejs':
    ensure          => installed,
    install_options => ['--allow-unauthenticated', '-f'],
  } ->
  vcsrepo { '/home/pi/workshops/workshop-maze-vr':
    ensure   => latest,
    provider => git,
    source   => 'git@192.168.1.100:workshop-maze-vr',
    revision => 'master',
    user     => 'pi',
  } ->
  exec { 'npm install of maze_vr':
    command => '/usr/bin/npm install',
    cwd     => '/home/pi/workshops/workshop-maze-vr',
    user    => 'pi',
    creates => '/home/pi/workshops/workshop-maze-vr/node_modules',
  }
}
