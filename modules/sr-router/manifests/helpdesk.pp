class sr-router::helpdesk-tracker{

  # Maintain a checkout of the external auth system
  vcsrepo { "/opt/sr/helpdesk-tracker":
    ensure => present,
    user => 'root',
    provider => git,
    source => "https://github.com/cjsoftuk/helpdesk-tracker.git",
    revision => "origin/master",
    force => true,
    require => [ Package[ "python-django" ], Package["libapache2-mod-wsgi"] ],
  }

  package{ "python-django":
    ensure => "latest",
  }

  file { "/usr/local/sbin/helpdesk-init":
    ensure => "present",
    source => "puppet:///modules/sr-router/helpdesk-init",
    mode => 700,
    owner => 'root',
    group => 'root',
  }

  exec { "/usr/local/sbin/helpdesk-init":
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/opt/sr/helpdesk-tracker/db.sqlite",
    notify => Service["apache2"],
    require => [ File["/usr/local/sbin/helpdesk-init"], Vcsrepo["/opt/sr/helpdesk-tracker"] ],
  }

  file { "/opt/sr/helpdesk-tracker/helpdesk.wsgi":
    ensure => "present",
    source => "puppet:///modules/sr-router/helpdesk.wsgi",
    require => Vcsrepo["/opt/sr/helpdesk-tracker"],
    mode => 644,
    owner => 'root',
    group => 'root',
  }

}
