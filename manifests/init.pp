class rabbitmq (

  $repo_scheme   = $rabbitmq::params::repo_scheme,
  $repo_domain   = $rabbitmq::params::repo_domain,
  $repo_port     = $rabbitmq::params::repo_port,
  $repo_user     = $rabbitmq::params::repo_user,
  $repo_pass     = $rabbitmq::params::repo_pass,
  $repo_path     = $rabbitmq::params::repo_path,
  $repo_resource = $rabbitmq::params::package,
  $key           = 'rabbitmq'

) inherits rabbitmq::params {

  anchor{'rabbitmq::begin':
    before  => Class['rabbitmq::install']
  }

  class {'rabbitmq::install':
    require  => Anchor['rabbitmq::begin']
  }

  class {'rabbitmq::config':
    require => Class['rabbitmq::install']
  }

  class {'rabbitmq::service':
    subscribe => Class['rabbitmq::config']
  }

  anchor{'rabbitmq::end':
    before  => Class['rabbitmq::service']
  }
}
