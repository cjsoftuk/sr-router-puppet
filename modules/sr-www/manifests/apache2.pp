class sr-www::apache2 {
  package { "apache2":
    ensure => latest,
  }

  package { "libapache2-mod-wsgi":
    ensure => "latest",
  }

  file { "/etc/apache2/sites-available/default":
    ensure => 'present',
    source => 'puppet:///modules/sr-www/default',
    notify => Service["apache2"],
  }

  file { "/etc/apache2/sites-available/auth.net.studentrobotics.org":
    ensure => 'present',
    source => 'puppet:///modules/sr-www/auth.net.studentrobotics.org',
    notify => Service["apache2"],
  }

  file { "/etc/apache2/sites-available/ntop.net.studentrobotics.org":
    ensure => 'present',
    source => 'puppet:///modules/sr-www/ntop.net.studentrobotics.org',
    notify => Service["apache2"],
  }

  file { "/etc/apache2/sites-available/helpdesk.net.studentrobotics.org":
    ensure => 'present',
    source => 'puppet:///modules/sr-www/helpdesk.net.studentrobotics.org',
    notify => Service["apache2"],
  }

  exec { "/usr/sbin/a2enmod proxy_http":
    creates => "/etc/apache2/mods-enabled/proxy_http.load",
    notify => Service["apache2"],
  }

  file { "/etc/apache2/sites-enabled/000-default":
    ensure => 'link',
    target => '/etc/apache2/sites-available/default',
    notify => Service["apache2"],
    require => File["/etc/apache2/sites-available/default"],
  }

  file { "/etc/apache2/sites-enabled/auth.net.studentrobotics.org":
    ensure => 'link',
    target => '/etc/apache2/sites-available/auth.net.studentrobotics.org',
    notify => Service["apache2"],
    require => File["/etc/apache2/sites-available/auth.net.studentrobotics.org"],
  }

  file { "/etc/apache2/sites-enabled/ntop.net.studentrobotics.org":
    ensure => 'link',
    target => '/etc/apache2/sites-available/ntop.net.studentrobotics.org',
    notify => Service["apache2"],
    require => File["/etc/apache2/sites-available/default"],
  }

  file { "/etc/apache2/sites-enabled/helpdesk.net.studentrobotics.org":
    ensure => 'link',
    target => '/etc/apache2/sites-available/helpdesk.net.studentrobotics.org',
    notify => Service["apache2"],
    require => File["/etc/apache2/sites-available/helpdesk.net.studentrobotics.org"],
  }

  file { "/etc/apache2/mods-enabled/proxy.load":
    ensure => 'link',
    target => '/etc/apache2/mods-available/proxy.load',
    notify => Service["apache2"],
  }

  file { "/etc/apache2/mods-enabled/proxy.conf":
    ensure => 'link',
    target => '/etc/apache2/mods-available/proxy.conf',
    notify => Service["apache2"],
  }

  service { "apache2":
    enable => true,
    ensure => running,
    subscribe => [ Package[ "apache2" ],
                 ],
  }

}
