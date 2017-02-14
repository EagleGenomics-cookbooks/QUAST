[![Build Status](https://travis-ci.org/EagleGenomics-cookbooks/quast.svg?branch=master)](https://travis-ci.org/EagleGenomics-cookbooks/quast)


# QUAST

Description
===========
This Cookbook installs QUAST, a tool to evaluate genome assemblies by computing various metrics.

Requirements
============

## Platform:

* Centos 6.5
* Centos 7.0
* Ubuntu 14.04

Notes
=====

Usage
=====
Simply include the recipe wherever you would like it installed, such as a run list (recipe[quast]) or a cookbook (include_recipe 'quast')

Version 4.3 of QUAST was released under GPL v2. Note that some of build-in third-party tools are not under GPL v2. See [LICENSE](http://quast.bioinf.spbau.ru/LICENSE.txt) for details.

## Testing
To test the recipe we use chef test kitchen:

kitchen converge

kitchen login

kitchen verify

kitchen destroy

kitchen test

Attributes
==========
See attributes/default.rb for default values.

default['quast']['version']

License and Authors
===================

* Authors:: Daniel Barrell (<chef@eaglegenomics.com>)
* Authors:: Nick James  (<chef@eaglegenomics.com>)

Copyright:: 2016, Eagle Genomics Ltd
    
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
