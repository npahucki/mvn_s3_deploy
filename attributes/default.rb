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

default[:mvn_s3_deploy][:access_key_id] = "YOUR_KEY_HERE"
default[:mvn_s3_deploy][:secret_access_key] = "YOUR_SECRET_KEY_HERE"
default[:mvn_s3_deploy][:bucket_name] = "BUCKET_NAME_HERE"
default[:mvn_s3_deploy][:artifactId] = "ARTIFACT_ID" # The maven artifactId for your war application
default[:mvn_s3_deploy][:groupId] = "GROUP_ID" # The maven groupId for your war application
default[:mvn_s3_deploy][:version] = "0.0.1-SNAPSHOT" # The version number NOTE: in the maven distribution sections, unsure uniqueVersion is false!
default[:mvn_s3_deploy][:war_name] = "WAR_OR_CONTEXT_NAME.war" # The name of the file as it will reside in the webapps directory and by default, the context name for the application

