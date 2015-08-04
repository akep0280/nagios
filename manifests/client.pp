class nagios::client {
#provide the installation directory and content to the client

  file { "/root/linux-nrpe-agent":
    source             => "puppet:///modules/nagios/linux-nrpe-agent",
    mode               => "0755",
    recurse            => true,
    source_permissions => use,
    require            => Exec["fullinstall"]
    }

  user { "nagios":
    name => "nagios",
    ensure => "present",
    }
#if xinetd.conf does not exist, run the install script
  exec { 'fullinstall':
    command => "/root/linux-nrpe-agent/fullinstall -n",
    onlyif  => '/usr/bin/test -d /root/linux-nrpe-agent',
    cwd     => "/root/linux-nrpe-agent",
    creates => "/etc/xinetd.d/nrpe",
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

 exec { 'removeinstall':
  command => "/bin/rm -rf /root/linux-nrpe-agent",
  onlyif  => "/usr/bin/test -f /etc/xinetd.d/nrpe",
  }

}
