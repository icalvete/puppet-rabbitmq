#puppet-rabbitmq

Puppet manifest to install and configure rabbitmq

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-rabbitmq.png)](http://travis-ci.org/icalvete/puppet-rabbitmq)

##Actions:

Install and configure [rabbitmq](http://www.rabbitmq.com/)

##Requires:

* Only works on Ubuntu
* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/icalvete/puppet-common but really only need:
  + An http server and a tgz package or use common::down_resource

##TODO:

* Refactor for more $::operatingsystem
* RabbitMQ HA.

##Authors:

Israel Calvete Talavera <icalvete@gmail.com>
