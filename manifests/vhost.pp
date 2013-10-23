define rabbitmq::vhost (

  $ensure = present

) {

  case $ensure {
    present : {
      exec {"add_vhost_${name}":
        command => "/usr/sbin/rabbitmqctl add_vhost ${name}",
        unless  => "/usr/sbin/rabbitmqctl list_vhosts | grep -i ${name}",
        require => Class['rabbitmq::service']
      }
    }
    absent : {
      exec {"del_vhost_${name}":
        command => "/usr/sbin/rabbitmqctl del_vhost ${name}",
        onlyif  => "/usr/sbin/rabbitmqctl list_vhosts | grep -i ${name}",
        require => Class['rabbitmq::service']
      }
    }
  }
}
