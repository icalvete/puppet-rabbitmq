class rabbitmq::config {

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
