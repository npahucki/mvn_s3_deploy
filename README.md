Description
===========

Designed to make deployments of tomcat wars from a private maven repository hosted on S3. The idea is that you may not want to share your wars 
with the world by hosting them on a public HTTP server as is required when using remote_file, and that deployment should be easy, repeatable and undoable. 
You can setup your maven project files so that 'mvn install' builds your project archive (war) and publishes it to S3 via the wagon S3 plugin (see :http://blog.anzix.net/2010/12/07/using-amazon-s3-as-a-maven-repository). From there, the version can be specified in the default attributes (or node based attributes on the chef server), allowing chef-client to find and deploy the war that was just deployed using maven or an older version of the war in the repository if necessary. Each node can have a different version deployed which can come in handy for doing testing before bringing an instance into a cluster.   

NOTE: For the time being the war is always downloaded and then the checksum checked against what is currently installed. A better way to do this would be to download the md5 signature from the maven repository, then do a head in S3 to see if it matches, and if it matches, not download the archive file. 

Big thanks to Christopher Peplin (<peplin@bueda.com>) from whom I borrowed the code to get started https://github.com/peplin/chef/blob/CHEF-1089/chef/lib/chef/provider/s3_file.rb.

Requirements
============

Platform
--------

Only tested on Ubuntu 10.10, but should work on all. 

Cookbooks
---------

* tomcat - for finding the location of the tomcat webapps dir and restarting tomcat after a deploy.

Attributes
==========

* node[:mvn_s3_deploy][:access_key_id]  - Your Amazon S3 Key, this key should have Get and ListBucket permission for the bucket specified. It's recommended that you create a key specifically for this use via IAM. 
* node[:mvn_s3_deploy][:secret_access_key] - Your Amazon S3 Secret Key
* node[:mvn_s3_deploy][:bucket_name] - The name of your bucket, without the s3 host name, e.g. my-maven-repo-bucket
* node[:mvn_s3_deploy][:artifactId] - The maven artifactId for your war application
* node[:mvn_s3_deploy][:groupId] - The maven groupId for your war application
* node[:mvn_s3_deploy][:version] - The version number NOTE: in the maven pom file in the distribution sections, ensure uniqueVersion is false!
* node[:mvn_s3_deploy][:war_name] - The name of the file as it will reside in the webapps directory and by default, the context name for the application

# Actions

- :create: Check/Download the archive, deploy if needed.

Usage
=====

On the build side, simply set up a private S3 based maven repository following these instructions One this is done, you can do 'mvn deploy' from your project root to deploy the latest code to the repository. After this is done, when chef-client is run on a client that includes the mvn_s3_deploy::default recipe, the archive will be fetched from the repository using the credentials and archive naming and versioning information provided in the attributes. If a new archive is installed, Tomcat will be restarted.  


License and Author
==================

Author: Nathan Pahucki (<n8@radi.cl>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
