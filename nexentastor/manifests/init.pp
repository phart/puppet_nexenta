###
### NMS settings -- this uses exec resources! Be careful about idempotency assumptions!
###
###
class nexentastor ($ses_check_flapping = 2, $nms_reporter_state = 'disable') {
    define nexentastor::nmc_exec ( $cmd = 'show faults' ) {
        exec { $name:
            command => "nmc -c '$cmd'",
            path => "/usr/local/bin:/usr/bin:/sbin",
        }
    }

    ### note that "changing" a property to the same value it already has will report failure
    nexentastor::nmc_exec { 'ses_check':
        cmd => "setup trigger ses-check property ival_anti_flapping -p $ses_check_flapping -y",
    }

    nexentastor::nmc_exec { 'nms_reporter':
        cmd => "setup reporter $nms_reporter_state",
    }
}
