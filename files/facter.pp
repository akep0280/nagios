class nagios::facter {

  file { "/etc/facter/fact.d/nagios.sh":
    source             => "puppet:///modules/nagios/facter",
    mode               => "0700",
    owner              => "root",
    }

}
