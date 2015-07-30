class nagios::client {
#provide the installation directory and content to the client
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
    creates => "/etc/xinetd.conf",
    path    => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
    }
}
