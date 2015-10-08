class client (){
  $packages = ['iceweasel', 'wget', 'git', 'vim', 'htop']

  exec { 'apt-get-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
  } ->
  package { $packages:
    ensure          => installed,
    install_options => ['--allow-unauthenticated', '-f'],
  }

  file { "/usr/share/backgrounds/devoxx4kids_wallpaper.png":
    ensure  => present,
    source  => "puppet:///modules/${module_name}/devoxx4kids_wallpaper.png",
  } ->
  exec { "set wallpaper":
    command => "/usr/bin/gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/devoxx4kids_wallpaper.png",
  }
}
