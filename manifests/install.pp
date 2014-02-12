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

      package{'erlang':
        ensure  => present
      }

      package {'erlang-nox':
        ensure  => present,
        require => Package['erlang']
      }

      exec {'rabbitmq_install_package':
        cwd     => '/tmp/',
        command => "/usr/bin/dpkg -i ${rabbitmq::repo_resource}",
        require => [Common::Down_resource['rabbitmq_get_package'], Package['erlang-nox']],
        unless  => '/usr/bin/dpkg -l rabbitmq-server | grep ii',
        notify  => Exec['kill_rabbitmq']
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
        unless  => '/usr/bin/which rabbitmqctl',
        notify  => Exec['kill_rabbitmq']
      }

    }
    default :{}
  }

  # Really ugly trick to fix a cluster support issue. Will be changed
  exec {'kill_rabbitmq':
    command     => '/bin/ps -u rabbitmq | /bin/grep -v PID | /usr/bin/awk {\'print $1\'} | /usr/bin/xargs /bin/kill -9',
    user        => 'root',
    provider    => 'shell',
    refreshonly => true,
    returns     => '123'
  }
}
