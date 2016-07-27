default['quast']['version'] = '4.2'
default['quast']['install_path'] = '/usr/local'
default['quast']['dir'] = default['quast']['install_path'] + '/' + 'quast-' + default['quast']['version']
default['quast']['filename'] = "quast-#{node['quast']['version']}.tar.gz"
default['quast']['url'] = "https://downloads.sourceforge.net/project/quast/#{node['quast']['filename']}"

default['python']['version'] = '2.7.9'
