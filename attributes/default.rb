# QUAST attributes
default['quast']['version'] = '4.2'
default['quast']['install_path'] = '/usr/local'
default['quast']['dir'] = default['quast']['install_path'] + '/' + 'quast-' + default['quast']['version']
default['quast']['filename'] = "quast-#{node['quast']['version']}.tar.gz"
default['quast']['url'] = "https://downloads.sourceforge.net/project/quast/#{node['quast']['filename']}"

# attributes to override default behaviour of cookbook java ( needed to compile GAGE java classes)
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = true
