#
# Cookbook:: tomcat8
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

%w(tomcat8 tomcat8-webapps tomcat8-docs-webapp tomcat8-admin-webapps).each do |pkg|
	package pkg do
	action :install
	end
end

=begin
package 'tomcat8' do
	action :install
end

package 'tomcat8-webapps' do
	action :install
end

package 'tomcat8-docs-webapp' do
	action :install
end

package 'tomcat-admin-webapps' do
	action :install
end
=end

service 'tomcat8' do
	action [:enable, :start]
end

directory '/tmp/unanet/temp' do
	owner 'tomcat'
	group 'tomcat'
	mode '0755'
	action :create
end

ruby_block "insert_line" do
	block do
		file = Chef::Util::FileEdit.new("/etc/tomcat8/tomcat8.conf")
		file.insert_line_if_no_match("JAVA_OPTS='${JAVA_OPTS} -Xms128m -Xmx512m -Djava.awt.headless=true' ")
		file.write_file
	end
end






