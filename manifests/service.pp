class rabbitmq::service {

  service{'rabbitmq-server':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true
  }
}
