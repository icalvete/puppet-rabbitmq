define rabbitmq::user (

  $ensure        = present,
  $user          = $name,
  $pass          = $name,
  $permissions   = '".*" ".*" ".*"',
  $vhost         = '/',
  $administrator = false

) {

  case $ensure {
    present : {
      exec {"add_user_${name}":
        command   => "/usr/sbin/rabbitmqctl add_user ${name} ${pass}",
        unless    => "/usr/sbin/rabbitmqctl list_users | grep -i ${name}",
        notify    => Exec["set_permissions_${name}"],
        tries     => 3,
        try_sleep => 5,
        require   => Class['rabbitmq::service'],
      }
      exec {"set_permissions_${name}":
        command     => "/usr/sbin/rabbitmqctl set_permissions -p ${vhost} ${user} ${permissions}",
        refreshonly => true,
        tries       => 3,
        try_sleep   => 10,
        require     => Exec["add_user_${name}"],
      }

      if $administrator {
        $admin_tag = 'administrator'
      } else {
        $admin_tag = ''
      }
      exec {"set_user_tags_${name}":
        command     => "/usr/sbin/rabbitmqctl set_user_tags ${user} ${admin_tag}",
        tries       => 3,
        try_sleep   => 10,
        require     => Exec["set_permissions_${name}"],
      }

    }
    absent : {
      exec {"del_user_${name}":
        command => "/usr/sbin/rabbitmqctl del_user ${name}",
        onlyif  => "/usr/sbin/rabbitmqctl list_users | grep -i ${name}",
        require => Class['rabbitmq::service']
      }
    }
  }
}
