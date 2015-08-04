class nagios::client {
#provide the installation directory and content to the client
  if
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
#if xinetd.conf does not exist, run the install script
  exec { 'fullinstall':
    command => "/root/linux-nrpe-agent/fullinstall -n",
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

 exec { 'removeinstall:'
  command => "rm -rf /root/linux-nrpe-agent",
  onlyif  => "test -f /etc/xinetd.d/nrpe"
  }

}
