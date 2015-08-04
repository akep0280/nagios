class nagios::facter {

  file { "/etc/puppetlabs/facter/facts.d/nagios.sh":
    source             => "puppet:///modules/nagios/facter",
    mode               => "0700",
    owner              => "root",
    }

}
