class nagios::client {

   file { "/root/linux-nrpe-agent"
    source => "puppet:///modules/nagios/linux-nrpe-agent",
    recurse => true,
    }

  }
}
