###
### forge modules for /etc/resolv.conf also don't like Solaris/OpenSolaris
###
### dnssearch overrides dnsdomain, unless it's set to empty string
###
class nexentastor::resolv_conf ($dnsdomain = 'mydomain.com',
                                $dnssearch = '',
                                $nameservers = [ '75.75.75.75', '75.75.76.76', '8.8.8.8' ]) {

    file { "/etc/resolv.conf":
        content => template("nexentastor/resolv.conf.erb"),
        owner => 'root',
        group => 'root',
        mode => '0444',
    }
}
