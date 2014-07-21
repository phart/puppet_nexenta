###
### /etc/snmp/snmpd.conf
###
###
# TBD   $extends = [ 'example /etc/example.sh' ]
class nexentastor::snmpd ($community = 'public',
    $descr = 'NexentaOS',
    $location = 'Cannot Be Empty or contain single quotes/apostrophes',
    $contact = 'rooty <youremail@yourcompany.com>',
    $trapsink = 'localhost',
    $link_notification = 'yes',
    $master = 'agentx') {

    augeas { "snmpDefaults":
        context => '/files/etc/snmp/snmpd.conf',
        changes => [ "set rocommunity $community",
                    "set sysDescr '$descr'",
                    "set sysLocation '$location'",
                    "set sysContact '$contact'",
                    "set trapsink $trapsink",
                    "set linkUpDownNotifications $link_notification",
                    "set master $master"
        ]
    }
}
