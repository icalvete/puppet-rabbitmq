define rabbitmq::cluster {

  exec {"stop_app_${name}":
    command   => 'Iusr/sbin/rabbitmqctl stop_app',
    unless    => "/usr/sbin/rabbitmqctl cluster_status | grep {nodes, | grep ${name}",
    notify    => Exec["join_cluster_${name}"],
    tries     => 3,
    try_sleep => 5,
    require   => Class['rabbitmq::service']
  }

  exec {"join_cluster_${name}":
    command     => "/usr/sbin/rabbitmqctl join_cluster rabbit@${name}",
    refreshonly => true,
    notify      => Exec["start_app_${name}"],
    tries       => 3,
    try_sleep   => 5,
    require     => [Class['rabbitmq::service'], Exec["stop_app_${name}"]]
  }

  exec {"start_app_${name}":
    command     => '/usr/sbin/rabbitmqctl start_app',
    refreshonly => true,
    tries       => 3,
    try_sleep   => 5,
    require     => [Class['rabbitmq::service'], Exec["join_cluster_${name}"]]
  }
}
