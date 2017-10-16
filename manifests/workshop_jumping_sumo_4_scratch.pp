class d4k::workshop_jumping_sumo_4_scratch {

  ensure_resource('package', ['openjdk-8-jdk', 'maven', 'scratch'],
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

  vcsrepo { '/home/pi/workshops/workshop-jumping-sumo-4-scratch':
    ensure   => latest,
    provider => git,
    source   => 'git@192.168.1.100:workshop-jumping-sumo-4-scratch',
    revision => 'master',
    user     => 'pi',
  }
}
