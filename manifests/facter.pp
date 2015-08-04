class nagios::facter {
#Custom facter to see if xinetd is installed or not
  file { "/etc/puppetlabs/facter/facts.d/nagios.sh":
    source             => "puppet:///modules/nagios/facter",
    mode               => "0700",
    owner              => "root",
    }

}
