class client (
  $user = 'd4k',
  $group = 'd4k'
){
  $packages = ['wget', 'git', 'vim', 'htop']

  exec { 'apt-get-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
  } ->
  package { $packages:
    ensure          => installed,
    install_options => ['--allow-unauthenticated', '-f'],
  }
}
