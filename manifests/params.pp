class rabbitmq::params {

  $repo_scheme = hiera('sp_repo_scheme')
  $repo_domain = hiera('sp_repo_domain')
  $repo_port   = hiera('sp_repo_port')
  $repo_user   = hiera('sp_repo_user')
  $repo_pass   = hiera('sp_repo_pass')
  $repo_path   = hiera('sp_repo_path')
  $package     = hiera('rabbitmq_package')

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {}
    /^(CentOS|RedHat)$/: {}
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
