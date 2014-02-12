class rabbitmq::install {

  common::down_resource {'rabbitmq_get_package':
    scheme   => $rabbitmq::repo_scheme,
    domain   => $rabbitmq::repo_domain,
    port     => $rabbitmq::repo_port,
    user     => $rabbitmq::repo_user,
    pass     => $rabbitmq::repo_pass,
    path     => $rabbitmq::repo_path,
    resource => $rabbitmq::repo_resource,
  }

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      exec {'install_erlangs':
        command => '/usr/bin/apt-get -q -y -o DPkg::Options::=--force-confold install erlang-nox',
        unless  => '/usr/bin/dpkg -l erlang-nox | grep ii'
      }

      exec {'rabbitmq_install_package':
        cwd     => '/tmp/',
        command => "/usr/bin/dpkg -i ${rabbitmq::repo_resource}",
        require => Common::Down_resource['rabbitmq_get_package'],
        unless  => '/usr/bin/dpkg -l rabbitmq-server | grep ii'
      }

      exec {'rabbitmq_install':
        cwd     => '/tmp/',
        command => '/usr/bin/apt-get -f install',
        require => Exec['rabbitmq_install_package'],
        unless  => '/usr/bin/dpkg -l rabbitmq-server | grep ii'
      }

    }
    /^(CentOS|RedHat)$/: {

      package{'erlang':
        ensure  => present
      }

      exec {'rabbitmq_install_package':
        cwd     => '/tmp/',
        command => "/bin/rpm -i ${rabbitmq::repo_resource}",
        require => Common::Down_resource['rabbitmq_get_package'],
        unless  => '/usr/bin/which rabbitmqctl'
      }

    }
  }

}
