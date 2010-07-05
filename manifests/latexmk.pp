# Class: userdots::latexmk
#
# This module manages latexmk
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
class userdots::latexmk {
  package { "latexmk":
    ensure => installed
  }

  file { "$home/.latexmkrc":
#    owner => $owner, group => $group,
    require => Package["latexmk"],
    ensure => present,
    source => "puppet:///modules/userdots/.latexmkrc",
  }
}
