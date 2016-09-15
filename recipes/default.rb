#
# Cookbook Name:: QUAST
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.

include_recipe 'build-essential'

include_recipe 'apt' if platform?('debian', 'ubuntu')

include_recipe 'java'

package ['tar'] do
  action :install
end

package 'zlib-devel' do
  package_name case node['platform_family']
               when 'rhel'
                 'zlib-devel'
               when 'debian'
                 'zlib1g-dev'
               end
end

# START matplotlib section ----------------------------------------------
# matplotlib is a python 2D plotting library which produces publication
# quality figures in a variety of hardcopy formats. It is not needed for
# QUAST to run but is recommended for drawing plots.
package ['gcc', 'python-matplotlib'] do
  action :install
end

case node['platform_family']
when 'debian'
  deps = %w(
    libpng-dev
    libfreetype6
    libfreetype6-dev
  )
when 'rhel'
  deps = %w(
    libpng-devel
    freetype
    freetype-devel
    gcc-c++
  )
else
  Chef::Log.fatal("platform family #{node['platform_family']} not supported")
end

deps.each do |pkg|
  package pkg
end
# END matplotlib section ------------------------------------------------

remote_file "#{Chef::Config[:file_cache_path]}/#{node['quast']['filename']}" do
  source node['quast']['url']
  action :create_if_missing
end

execute 'un-tar quast' do
  command "tar xzf #{Chef::Config[:file_cache_path]}/#{node['quast']['filename']} -C #{node['quast']['install_path']}"
  not_if { ::File.exist?("#{node['quast']['dir']}/quast") }
end

execute './install_full.sh' do
  cwd node['quast']['dir']
  not_if { ::File.exist?("#{node['quast']['dir']}/quast.pyc") }
end

magic_shell_environment 'PATH' do
  value '$PATH:' + node['quast']['dir']
end
