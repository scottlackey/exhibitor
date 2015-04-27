class exhibitor::install(
  $version = $exhibitor::version,
  $install_dir = $exhibitor::install_dir,
  $pom_url = "https://raw.githubusercontent.com/Netflix/exhibitor/master/exhibitor-standalone/src/main/resources/buildscripts/standalone/maven/pom.xml"
) {

  file { $install_dir:
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    ensure => directory
  }
  file { "$install_dir/$version":
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    ensure => directory
  }

  exec { 'download-pom':
    command => "/usr/bin/curl -o  ${install_dir}/${version}/pom.xml $pom_url",
    creates => "${install_dir}/${version}/pom.xml",
    require => File["$install_dir/$version"],
    unless  => "/usr/bin/test -f ${install_dir}/${version}/pom.xml",
  }
  exec { 'build-exhibitor':
    command => "/usr/bin/mvn clean package -f ${install_dir}/${version}/pom.xml && /bin/cp ${install_dir}/${version}/target/exhibitor-${version}.jar ${install_dir}/exhibitor-standalone-${version}.jar",
    creates => "${install_dir}/exhibitor-standalone-${version}.jar",
    require => [ File[$install_dir], Exec['download-pom'] ],
    unless  => "/usr/bin/test -f ${install_dir}/exhibitor-standalone-${version}.jar",
    notify  => Service['exhibitor'],
  }
}
