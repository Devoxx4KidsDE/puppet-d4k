class d4k::workshop_jumping_sumo {

  ensure_resource('package', ['openjdk-8-jdk', 'maven'],
    { 'ensure'          => 'present',
      'install_options' => ['--allow-unauthenticated', '-f'],
    }
  )

  package { 'openjdk-7-jdk':
    ensure => 'purged'
  }

  vcsrepo { '/home/pi/workshops/workshop-jumping-sumo':
    ensure   => latest,
    provider => git,
    source   => 'git@192.168.1.100:workshop-jumping-sumo',
    revision => 'master',
    user     => 'pi',
  } ->
  exec { 'mvn clean package for jumping sumo':
    command => '/usr/bin/mvn clean package',
    cwd     => '/home/pi/workshops/workshop-jumping-sumo',
    user    => 'pi',
    creates => '/home/pi/workshops/workshop-jumping-sumo/target',
  }
}
