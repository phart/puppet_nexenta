###
### logadm based on puppetlabs "logadm_patterns" custom type
### http://projects.puppetlabs.com/projects/1/wiki/logadm_patterns
###
# this needs to be redone similarly to /etc/system with a hash as argument
class nexentastor::logadm {
    logadm { "/var/log/nmv.log":
        count          => 2,
        size           => 10m,
    }
    logadm { "/var/log/nms.log":
        count          => 2,
        size           => 10m,
    }
    logadm { "/var/log/nmcd.log":
        count          => 2,
        size           => 10m,
    }
    logadm { "/var/log/nmdtrace.log":
        count          => 2,
        size           => 10m,
    }
}
