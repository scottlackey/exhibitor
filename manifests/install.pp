class exhibitor::install(
  $version = $exhibitor::version,
  $install_dir = $exhibitor::install_dir,
  $maven_url = "https://repo1.maven.org/maven2/com/netflix/exhibitor/exhibitor-standalone/${::exhibitor::version}/exhibitor-standalone-${::exhibitor::version}.pom",
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
    command => "/usr/bin/curl -o  ${install_dir}/${version}/pom.xml $maven_url",
    creates => "${install_dir}/${version}/pom.xml",
    require => File["$install_dir/$version"],
    unless  => "/usr/bin/test -f ${install_dir}/${version}/pom.xml",
  }
  exec { 'build-exhibitor':
    command => "/usr/bin/mvn clean package -f ${install_dir}/${version}/pom.xml && /bin/cp ${install_dir}/${version}/target/exhibitor-standalone-${version}.jar ${install_dir}/exhibitor-standalone-${version}.jar",
    creates => "${install_dir}/exhibitor-standalone-${version}.jar",
    require => [ File[$install_dir], Exec['download-pom'] ],
    unless  => "/usr/bin/test -f ${install_dir}/exhibitor-standalone-${version}.jar",
  }
}
