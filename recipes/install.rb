#
# Cookbook Name:: certbot
# Recipe:: install
#
# Copyright 2016 Inviqa UK Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'yum-epel' if platform_family?('rhel')

case node['certbot']['install_method']
when 'snap'
  include_recipe 'certbot::snap'
when 'package'
  package node['certbot']['package']
when 'certbot-auto'
  if node['platform'] == 'ubuntu' && node['platform_version'].to_f <= 12.04
    remote_file node['certbot']['bin'] do
      source 'https://raw.githubusercontent.com/certbot/certbot/0.31.x/certbot-auto'
      mode 0755
    end
  else
    remote_file node['certbot']['bin'] do
      source 'https://raw.githubusercontent.com/certbot/certbot/master/certbot-auto'
      mode 0755
    end
  end
end
