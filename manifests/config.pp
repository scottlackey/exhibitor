#exhibitor::config
class exhibitor::config(
  $defaultfile_opts = $exhibitor::defaultfile_opts,
  $install_dir = $exhibitor::install_dir,
  $servers  = $exhibitor::servers,
  $zk_data_dir = $exhibitor::zk_data_dir,
  $zk_log_dir = $exhibitor::zk_log_dir,

  $rolling_hostnames = $exhibitor::rolling_hostnames,
  $rolling_hostnames_index = $exhibitor::rolling_hostnames_index,
  $rolling_auto_manage_instances = $exhibitor::rolling_auto_manage_instances,
  $rolling_auto_manage_instances_apply_all_at_once = $exhibitor::rolling_auto_manage_instances_apply_all_at_once,
  $rolling_auto_manage_instances_fixed_ensemble_size = $exhibitor::rolling_auto_manage_instances_fixed_ensemble_size,
  $rolling_auto_manage_instances_settling_period_ms = $exhibitor::rolling_auto_manage_instances_settling_period_ms,
  $rolling_backup_extra = $exhibitor::rolling_backup_extra,
  $rolling_backup_max_store_ms = $exhibitor::rolling_backup_max_store_ms,
  $rolling_backup_period_ms = $exhibitor::rolling_backup_period_ms,
  $rolling_check_ms = $exhibitor::rolling_check_ms,
  $rolling_cleanup_max_files = $exhibitor::rolling_cleanup_max_files,
  $rolling_cleanup_period_ms = $exhibitor::rolling_cleanup_period_ms,
  $rolling_client_port = $exhibitor::rolling_client_port,
  $rolling_connect_port = $exhibitor::rolling_connect_port,
  $rolling_election_port = $exhibitor::rolling_election_port,
  $rolling_java_environment = $exhibitor::rolling_java_environment,
  $rolling_log_index_directory = $exhibitor::rolling_java_environment,
  $rolling_log4j_properties = $exhibitor::rolling_log4j_properties,
  $rolling_observer_threshold = $exhibitor::rolling_observer_threshold,
  $rolling_zoo_cfg_extra = $exhibitor::rolling_zoo_cfg_extra,

  $auto_manage_instances = $exhibitor::auto_manage_instances,
  $auto_manage_instances_apply_all_at_once = $exhibitor::auto_manage_instances_apply_all_at_once,
  $auto_manage_instances_fixed_ensemble_size = $exhibitor::auto_manage_instances_fixed_ensemble_size,
  $auto_manage_instances_settling_period_ms = $exhibitor::auto_manage_instances_settling_period_ms,
  $zoo_cfg_extra = $exhibitor::zoo_cfg_extra,
  $backup_extra = $exhibitor::backup_extra,
  $backup_max_store_ms = $exhibitor::backup_max_store_ms,
  $backup_period_ms = $exhibitor::backup_period_ms,
  $check_ms = $exhibitor::check_ms,
  $cleanup_max_files = $exhibitor::cleanup_max_files,
  $cleanup_period_ms = $exhibitor::cleanup_period_ms,
  $client_port = $exhibitor::client_port,
  $connect_port = $exhibitor::connect_port,
  $election_port = $exhibitor::election_port,
  $java_environment = $exhibitor::java_environment,
  $log_index_directory = $exhibitor::log_index_directory,
  $log4j_properties = $exhibitor::log4j_properties,
  $observer_threshold = $exhibitor::observer_threshold,
) {
  require exhibitor::install

  file { '/etc/default/exhibitor':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('exhibitor/etc/default/exhibitor.erb')
  }
  file { "${install_dir}/exhibitor.properties":
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('exhibitor/exhibitor.properties.erb'),
    notify  => Class['exhibitor::service'],
  }
}
