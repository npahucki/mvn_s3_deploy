#
# Author:: Nathan Pahucki (<n8@radi.cl>)
# Cookbook Name:: mvn_s3_deploy
#
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
#

include_recipe "tomcat"

# Make sure gem is installed
r = gem_package "aws-s3" do
  action :nothing
end
r.run_action(:install)
require 'rubygems'
Gem.clear_paths
require 'aws/s3'

# Build the URL based on Maven2 Repository Layout
props = node["mvn_s3_deploy"];
file_name = props["artifactId"] + "-" + props["version"] + ".war"
full_url = "s3://#{props['bucket_name']}/release/#{props['groupId'].gsub('.','/')}/#{props['artifactId']}/#{props['version']}/#{file_name}"
file_path = node["tomcat"]["webapp_dir"] + "/"  + (props["war_name"] || file_name)

# Run the file download
mvn_s3_deploy file_path do
  access_key_id node["mvn_s3_deploy"]["access_key_id"]
  secret_access_key node["mvn_s3_deploy"]["secret_access_key"]
  source full_url
  backup false
  mode "0644"
  notifies :restart, resources(:service => "tomcat")
end
