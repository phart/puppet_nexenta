###
### authorized keys for root user
###
###
# deliberately no default -- this should bomb if none are provided
class nexentastor::auth_keys ($authkeys) {
    file { '/root/.ssh/authorized_keys':
        owner => 'root',
        group => 'root',
        mode => '0600',
        # could use join of the array, but then there will be no final newline
        content => template('nexentastor/authorized_keys.erb'),
    }
}

