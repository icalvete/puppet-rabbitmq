class rabbitmq::params {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      $repo_scheme = hiera('sp_repo_scheme')
      $repo_domain = hiera('sp_repo_domain')
      $repo_port   = hiera('sp_repo_port')
      $repo_user   = hiera('sp_repo_user')
      $repo_pass   = hiera('sp_repo_pass')
      $repo_path   = hiera('sp_repo_path')
      $package     = hiera('rabbitmq_package')
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
