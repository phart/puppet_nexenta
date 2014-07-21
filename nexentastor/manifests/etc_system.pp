###
### /etc/system
###
###
# deliberately no default -- this should bomb if none are provided
class nexentastor::etc_system ($system_settings) {
    # $name is the /etc/system variable name, whether defined with a module or not
    #    this expects that $name will be unique WITHOUT its module name prepended
    # $system_settings is a hash/dictionary set up prior to calling
    #    hash format: 
    #     {  'system_variable_name' => { module => 'module_name', value => 'value' }
    #       this expects that the operator will always be =, this can be handled but will 
    #       requier a change to the hash format
    define nexentastor::systementry ($module=$nexentastor::etc_system::system_settings[$name]['module'],
                                     $op='=', $value=$nexentastor::etc_system::system_settings[$name]['value']) {
        if ($value == '') {
            fail("nexentastor::systementry called with empty value")
        }
        if ($module == '') {
            augeas { "$name":
                context => '/files/etc/system',
                changes => [
                    "defnode target /files/etc/system/set[variable='$name'] ''",
                    "set \$target/variable '$name'",
                    "set \$target/operator '$op'",
                    "set \$target/value $value",
                ],
            }
        } else {
            augeas { "$module_$name":
                context => '/files/etc/system',
                changes => [
                    "defnode target /files/etc/system/set[variable='$name'] ''",
                    "set \$target/module '$module'",
                    "set \$target/variable '$name'",
                    "set \$target/operator '$op'",
                    "set \$target/value $value",
                ],
            }
        }
    }

    $system_vars = keys($system_settings)
    nexentastor::systementry { $system_vars : }
}
