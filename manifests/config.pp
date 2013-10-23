class rabbitmq::config {

  file{ 'erlang.cookie':
    ensure  => present,
    path    => '/var/lib/rabbitmq/.erlang.cookie',
    content => $rabbitmq::key,
    owner   => 'rabbitmq',
    group   => 'rabbitmq',
    mode    => '0400',
  }

  exec {'rabbitmq_enable_management':
    command     => '/usr/sbin/rabbitmq-plugins enable rabbitmq_management',
    unless      => '/usr/sbin/rabbitmq-plugins list | grep rabbitmq_management | grep E',
    environment => 'HOME=/root'
  }

  exec {'rabbitmq_enable_stomp':
    command     => '/usr/sbin/rabbitmq-plugins enable rabbitmq_stomp',
    unless      => '/usr/sbin/rabbitmq-plugins list | grep rabbitmq_stomp | grep E',
    environment => 'HOME=/root'
  }
}
