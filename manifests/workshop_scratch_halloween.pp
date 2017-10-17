class d4k::workshop_scratch_halloween {

  ensure_resource('package', ['scratch', 'nuscratch'],
    {
      'ensure'          => 'present',
      'install_options' => ['--allow-unauthenticated', '-f'],
    }
  )

  vcsrepo { '/home/pi/workshops/workshop-scratch-halloween':
    ensure   => latest,
    provider => git,
    source   => 'git@192.168.1.100:workshop-scratch-halloween',
    revision => 'master',
    user     => 'pi',
  }
}
