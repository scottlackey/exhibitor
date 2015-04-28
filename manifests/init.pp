#exhibitor init class
class exhibitor(
  $version = '1.5.5',
  $install_dir = '/opt/exhibitor',
  $conf_dir = '/etc/exhibitor',
  $servers = ['localhost'],
  $defaultfile_opts = {
    'port'        => '8080',
    'configtype'  => 'file',
    'fsconfigdir' =>  '/opt/exhibitor',
    'hostname'    =>  $fqdn,
  },
  $zk_data_dir = '/mnt/zookeeper/data',
  $zk_log_dir = '/mnt/zookeeper/log',
  $zk_install_dir = '/usr/share/zookeeper',
  #exhibitor.properties options

  $rolling_hostnames='',
  $rolling_hostnames_index='',
  $rolling_auto_manage_instances='0',
  $rolling_auto_manage_instances_apply_all_at_once='1',
  $rolling_auto_manage_instances_fixed_ensemble_size='0',
  $rolling_auto_manage_instances_settling_period_ms='180000',
  $rolling_backup_extra='',
  $rolling_backup_max_store_ms='86400000',
  $rolling_backup_period_ms='60000',
  $rolling_check_ms='30000',
  $rolling_cleanup_max_files='3',
  $rolling_cleanup_period_ms='43200000',
  $rolling_client_port='2181',
  $rolling_connect_port='2888',
  $rolling_election_port='3888',
  $rolling_java_environment='',
  $rolling_log_index_directory='',
  $rolling_log4j_properties='',
  $rolling_observer_threshold='999',
  $rolling_zoo_cfg_extra='syncLimit\=5&tickTime\=2000&initLimit\=10',

  $auto_manage_instances='',
  $auto_manage_instances_apply_all_at_once='1',
  $auto_manage_instances_fixed_ensemble_size='0',
  $auto_manage_instances_settling_period_ms='180000',
  $zoo_cfg_extra='syncLimit\=5&tickTime\=2000&initLimit\=10&quorumListenOnAllIPs\=true',
  $backup_extra='',
  $backup_max_store_ms='86400000',
  $backup_period_ms='60000',
  $check_ms='30000',
  $cleanup_max_files='3',
  $cleanup_period_ms='43200000',
  $client_port='2181',
  $connect_port='2888',
  $election_port='3888',
  $java_environment='',
  $log_index_directory='',
  $log4j_properties='',
  $observer_threshold='999',
) {
  require 'maven'
  contain exhibitor
  contain exhibitor::install
  contain exhibitor::config
  contain exhibitor::service
}
