####
#### NMS settings -- this uses exec resources! Be careful about idempotency assumptions!
####
####    currently only supports these two parameters
####
class { 'nexentastor':
    ses_check_flapping => 2,
    nms_reporter_state => 'disable',
}


###
### authorized keys for root user
###
###
$ourkeys = [ 
'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl8WCG4twGWegmgbKADlKR9ojrPs1Qp/XXOsck03Gs7dFPiefIlS71T9kIHLMlpbu0rNrLBdC6LU3n2WoPYxOIjBTnYIi4yf6XhaBamRUBdAuzbtLDxToPDasdHJV7YIelYVUi3fEzy4WSuWhI9vO7oigA4HZKhVgQItcGmGaWxPundRhP3jQ60pxSiU/75dnHiUSL6kCTuO/aAhLQUuFrPEd0paKXIHPOGY1mCBfNoLzBer9GjCqTMbMgiDslye1UUDeyrb/eCA8VKblS8zR2CkoL9WKm4LcOtkwGRPuP4SRPJQ4ze2JrpCg6xF6cdEydsOcoiBF1bcjokeQEgU1H pete.hartman@nexenta.com',
]

class { 'nexentastor::auth_keys':
    authkeys => $ourkeys,
}


####
#### logadm based on puppetlabs "logadm_patterns" custom type
#### http://projects.puppetlabs.com/projects/1/wiki/logadm_patterns
####
#### this should be redone to allow more flexibility, currently only sets defaults
####
include nexentastor::logadm


####
#### /etc/default/nfs settings
####
####
class { 'nexentastor::nfs_defaults':
    nfsd_listen_backlog => 64,
    nfsd_protocol => "ALL",
    nfsd_servers => 1024,
    lockd_listen_backlog => 64,
    lockd_servers => 1024,
    lockd_retransmit_timeout => 5,
    grace_period => 90,
    nfs_server_versmax => 3,
    nfs_client_versmax => 3,
}


####
#### ntp settings
####
####
$ntpservers = [ "0.pool.ntp.org", "1.pool.ntp.org" ]

class { 'nexentastor::ntp':
    drift_file => "/etc/inet/ntp.drift",
    server_list => $ntpservers,
}


####
#### /etc/snmp/snmpd.conf
####
####
# not sure how this piece works
#$extends = [ 'example /etc/example.sh' ]
class { 'nexentastor::snmpd':
    community => 'public',
    descr => 'NexentaOS',
    location => 'Cannot Be Empty or contain single quotes/apostrophes',
    contact => 'root <youremail@yourcompany.com>',
    trapsink => 'localhost',
    link_notification => 'yes',
    master => 'agentx',
}


####
#### /etc/syslog.conf loghosts only
####
####
$ourloghosts = [ 'host1', 'host2' ]

class { 'nexentastor::syslog_conf':
    loghosts => $ourloghosts,
}


####
#### forge modules for /etc/resolv.conf also don't like Solaris/OpenSolaris
####
#### dnssearch overrides dnsdomain, unless it's set to empty string (in template)
####
$ournameservers = [ '75.75.75.75', '75.75.76.76', '8.8.8.8' ]

class { 'nexentastor::resolv_conf':
    # dnssearch => 'search domains',
    dnsdomain => 'comcast.com',
    nameservers => $ournameservers,
}

####
#### /etc/system settings
####
#### additional values can be added to the hash
####
#### hash format: 
####   {  'system_variable_name' => { module => 'module_name', value => 'value' }
####
####       this expects that the operator in /etc/system will always be =, a change will
####       require a (minor) change to the hash format
$oursettings = {
    'zfs_resilver_delay'  => { module => 'zfs', value => 2 },
    'zfs_txg_synctime_ms' => { module => 'zfs', value => 5000 },
    'zfs_txg_timeout'     => { module => 'zfs', value => 10 },
    'l2arc_write_boost'   => { module => 'zfs', value => 83886080 },
    'swapfs_minfree'      => { module => '',    value => 1048576 },
}

class { 'nexentastor::etc_system':
    system_settings => $oursettings,
}
