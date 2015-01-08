# Global
default['uchiwa']['version'] = '0.4.0-1'
default['uchiwa']['install_method'] = 'repo'
default['uchiwa']['apt_repo_url'] = 'http://repos.sensuapp.org/apt'
default['uchiwa']['yum_repo_url'] = 'http://repos.sensuapp.org'
default['uchiwa']['use_unstable_repo'] = false
default['uchiwa']['http_url'] = 'http://dl.bintray.com/palourde/uchiwa'
default['uchiwa']['owner'] = 'uchiwa'
default['uchiwa']['group'] = 'uchiwa'
default['uchiwa']['sensu_homedir'] = '/etc/sensu'
default['uchiwa']['add_repo'] = true
default['uchiwa']['package_options'] = nil

# Set to false if you want to wrap this with runit or another process monitor
default['uchiwa']['manage_service'] = true

# Uchiwa Settings
default['uchiwa']['settings']['user'] = 'admin'

databag_name = node['databag']['databag_name']
if node['databag'].has_key?('databag_secret')
  databag_secret = node['databag']['databag_secret']
elsif node['databag'].has_key?('secret_url')
  databag_secret = get_secret_from_url(node['databag']['secret_url'])
end

passwords = Chef::EncryptedDataBagItem.load(databag_name, 'passwords', secret=databag_secret)  
default['uchiwa']['settings']['pass'] = passwords['uchiwa']
#default['uchiwa']['settings']['pass'] = 'supersecret'

default['uchiwa']['settings']['refresh'] = 5
default['uchiwa']['settings']['host'] = '0.0.0.0'
default['uchiwa']['settings']['port'] = 3000

# APIs Settings
default['uchiwa']['api'] = [
  {
    'name' => 'Sensu',
    'host' => '127.0.0.1',
    'port' => 4567,
    'path' => '',
    'ssl' => false,
    'timeout' => 5
  }
]

