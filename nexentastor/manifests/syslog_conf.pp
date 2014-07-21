###
### /etc/syslog.conf loghosts only
###    augeas does not like M4 macros in config files
###    and appears to have no means to pre-process them
###
# deliberately no default -- this should bomb if none are provided
class nexentastor::syslog_conf ($loghosts) {

    file { "/etc/syslog.conf":
        content => template("nexentastor/syslog.conf.erb"),
        owner => 'root',
        group => 'sys',
        mode => '0644',
    }
}
