###
### most ntp puppet modules don't support Solaris or OpenSolaris
### one that does, uses a much more complex template
###   and Puppet does not currently recognize Nexenta as using
###   SMF for its service provider (even if explicitly defined)
###   so it still blows up
###
### so doing a simple template only
###
class nexentastor::ntp ($drift_file = "/etc/inet/ntp.drift",
                        $server_list = [ "0.pool.ntp.org", "1.pool.ntp.org" ]) {

    file { "/etc/inet/ntp.conf":
        content => template("nexentastor/ntp.conf.erb"),
        owner => 'root',
        group => 'sys',
        mode => '0644',
    }
}
