#
# Cookbook Name:: QUAST
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.

include_recipe 'build-essential'
include_recipe 'apt'
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

# Python versions older than 2.7.9 will report an SNIMissingWarning when
# trying to install the matplotlib package, therefore specify it here:
include_recipe 'poise-python'

python_runtime '2' do
  version '2.7'
end

# version 1.8.0 required for matplotlib 1.3.1 to correctly install
python_package 'numpy' do
  version '1.8.0'
end

# Matplotlib Python library for drawing plots, QUAST is tested with 1.3.1
python_package 'matplotlib' do
  version '1.3.1'
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

# The executables are python scripts, let's not add in symlinks atm....
# this symlinks every executable in the install subdirectory to the top of the directory tree
# so that they are in the PATH
# execute "find #{node['quast']['dir']} -maxdepth 1 -name '*.py' -executable -type f -exec ln -sf {} . \\;" do
#   cwd node['quast']['install_path'] + '/bin'
# end
