# Class: userdots::emacs
#
# This module manages emacs
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class userdots::emacs {
  
  package { "emacs":
    ensure => installed,
  }
  
  File {
    owner => $user, group => $group,
    require => Package["emacs"],
  }

  file {
    "$home/.emacs.d":
      require => Package["emacs"],
      ensure => directory;
    [ "$home/.emacs.d/auto-install", "$home/.emacs.d/template",
      "$home/.emacs.d/config", "$home/.emacs.d/elisp" ]:
        require => File["$home/.emacs.d"],
        ensure => directory;
  }

  file { "$home/.emacs.d/init.el":
    ensure => present,
    source => "puppet:///modules/userdots/.emacs.d/init.el",
  }
}

define userdots::emacs::template ( $source = '', $content = '') {
# FIXME: content case
  file { "$home/.emacs.d/template/$name":
      require => File["$home/.emacs.d/template"],
      source => "puppet:///modules/userdots/.emacs.d/template/$name",
      ensure => present;
  }
}

define userdots::emacs::elisp ( $package = '', $url = '', $conf = 'false' ) {
  case $package {
    '': {}
    default: {
      package { "$name":
        ensure => installed,
      }
    }
  }

  case $url {
    '': {}
    default: {
      exec { "auto-install-${name}":
        command => 'wget -q -O- $url'
      }
    }
  }

  if $conf == 'true' {
    userdots::emacs::conf { "$name":
    }
  }
}

define userdots::emacs::conf () {
  file {
    "$home/.emacs.d/config/mode_${name}.el":
      require => File["$home/.emacs.d/config"],
      source => "puppet:///modules/userdots/.emacs.d/config/mode_${name}.el",
      ensure => present:
  }  
}

# FIXME: implement
#define home::emacs::globalkey () {
#}

