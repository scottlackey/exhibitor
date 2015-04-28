#exhibitor::service
class exhibitor::service(
  $version = $exhibitor::version,
) {

  file { '/etc/init.d/exhibitor':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('exhibitor/etc/init.d/exhibitor.erb'),
    require => Exec['build-exhibitor'],
  }

  service { 'exhibitor':
    ensure  => 'running',
    require => File['/etc/init.d/exhibitor']
  }
}
