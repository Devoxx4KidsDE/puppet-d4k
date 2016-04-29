class d4k::workshop_jumping_sumo {

  ensure_resource('package', ['openjdk-8-jdk', 'maven'],
    {
      'ensure'          => 'present',
      'install_options' => ['--allow-unauthenticated', '-f'],
    }
  )

  ensure_resource ('package', ['openjdk-7-jdk', 'oracle-java8-jdk'],
    {
      ensure => 'purged'
    }
  )

  vcsrepo { '/home/pi/workshops/workshop-jumping-sumo':
    ensure   => latest,
    provider => git,
    source   => 'git@192.168.1.100:workshop-jumping-sumo',
    revision => 'master',
    user     => 'pi',
  }
}
