class nagios::client {
#If xinetd is not installed,  install nagios installation directory, create user nagios, install nagios client, and change permissions on executables

  if $xinetd == "false" {
    file { "/root/linux-nrpe-agent":
    source             => "puppet:///modules/nagios/linux-nrpe-agent",
    mode               => "0755",
    recurse            => true,
    source_permissions => use,
    }
    user { "nagios":
      name => "nagios",
      ensure => "present",
      }
    exec { 'fullinstall':
        command => "/root/linux-nrpe-agent/fullinstall -n",
        cwd     => "/root/linux-nrpe-agent",
        path    => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
        before => File['/usr/local/nagios/libexec'],
        }
    file {'/usr/local/nagios/libexec':
          ensure  => 'directory',
          owner   => 'root',
          group   => 'nagios',
          recurse => 'true',
          require => Exec['fullinstall'],

      }
  }
#If xinetd is installed, remove the nagios installation directory
  elsif $xinetd == "true" {
    file { "/root/linux-nrpe-agent":
    ensure             => absent,
    path               => "/root/linux-nrpe-agent",
    recurse            => true,
    purge              => true,
    force              => true,
    }
}
}
