###
### /etc/default/nfs settings
### using variables, could substitute with parameters or hiera values
###
### note that using augeas, have to add excludes to auto-loaded lenses
###   for files ending in ,v (under RCS control)  See shellvars.aug and
###   httpd.aug
###
class nexentastor::nfs_defaults  ( $nfsd_listen_backlog = 64,
                                   $nfsd_protocol = "ALL",
                                   $nfsd_servers = 1024,
                                   $lockd_listen_backlog = 64,
                                   $lockd_servers = 1024,
                                   $lockd_retransmit_timeout = 5,
                                   $grace_period = 90,
                                   $nfs_server_versmax = 3,
                                   $nfs_client_versmax = 3 ) {
    augeas { "nfsDefaults":
        context => "/files/etc/default/nfs",
        changes => [ "set NFSD_LISTEN_BACKLOG $nfsd_listen_backlog",
                    "set NFSD_PROTOCOL $nfsd_protocol",
                    "set NFSD_SERVERS $nfsd_servers",
                    "set LOCKD_LISTEN_BACKLOG $lockd_listen_backlog",
                    "set LOCKD_SERVERS $lockd_servers",
                    "set LOCKD_RETRANSMIT_TIMEOUT $lockd_retransmit_timeout",
                    "set GRACE_PERIOD $grace_period",
                    "set NFS_SERVER_VERSMAX $nfs_server_versmax",
                    "set NFS_CLIENT_VERSMAX $nfs_client_versmax",
        ]
    }
}
