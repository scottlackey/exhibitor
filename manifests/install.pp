#class exhibitor::install
class exhibitor::install(
  $version = $exhibitor::version,
  $install_dir = $exhibitor::install_dir,
  $pom_url = 'https://raw.githubusercontent.com/Netflix/exhibitor/master/exhibitor-standalone/src/main/resources/buildscripts/standalone/maven/pom.xml'
) {

  file { $install_dir:
    ensure => directory,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }
  file { "${install_dir}/${version}":
    ensure => directory,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  file { "${install_dir}/${version}/pom.xml":
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('exhibitor/pom.xml.erb'),
    notify  => Class['exhibitor::service'],
  }

  exec { 'build-exhibitor':
    command => "/usr/bin/mvn clean package -f ${install_dir}/${version}/pom.xml && /bin/cp ${install_dir}/${version}/target/exhibitor-${version}.jar ${install_dir}/exhibitor-standalone-${version}.jar",
    creates => "${install_dir}/exhibitor-standalone-${version}.jar",
    require => File["${install_dir}/${version}/pom.xml"],
    unless  => "/usr/bin/test -f ${install_dir}/exhibitor-standalone-${version}.jar",
    notify  => Service['exhibitor'],
  }
}
