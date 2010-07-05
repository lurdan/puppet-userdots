# Class: userdots::lv
#
# This class manages lv
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
class userdots::lv {
  
  package { "lv":
    ensure => installed
  }

  file { "$home/.lv":
    require => Package["lv"],
#    content => "-c",
    source => "puppet:///modules/userdots/.lv",
    ensure => present,
  }
}
