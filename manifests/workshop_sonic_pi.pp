class d4k::workshop_sonic_pi {

  ensure_resource('package', ['sonic-pi'],
    {
      'ensure'          => 'present',
      'install_options' => ['--allow-unauthenticated', '-f'],
    }
  )

  vcsrepo { '/home/pi/workshops/workshop-sonic-pi':
    ensure   => latest,
    provider => git,
    source   => 'git@192.168.1.100:workshop-sonic-pi',
    revision => 'master',
    user     => 'pi',
  }
}
