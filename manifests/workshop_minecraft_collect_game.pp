class d4k::workshop_minecraft_collect_game {

  ensure_resource('package', ['minecraft-pi', 'python'], { 'ensure' => 'present' })

  vcsrepo { '/home/pi/workshops/workshop-minecraft-modding-raspberry-pi':
    ensure   => latest,
    provider => git,
    source   => 'git@192.168.1.100:workshop-minecraft-modding-raspberry-pi',
    revision => 'master',
    user     => 'pi',
  }
}
