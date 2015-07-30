class nagios::client {
#provide the installation directory and content to the client
  file { "/root/linux-nrpe-agent":
    source => "puppet:///modules/nagios/linux-nrpe-agent",
    recurse => true,
    }

#if xinetd.conf does not exist, run the install script
  exec { 'fullinstall':
    command => "fullinstall -n",
    cwd     => "/root/linux-nrpe-agent",
    creates => "/etc/xinetd.conf",
    path    => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
    }
}
