#
# Cookbook:: tomcat8
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

%w(tomcat tomcat-webapps tomcat-docs-webapp tomcat-admin-webapps).each do |pkg|
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

service 'tomcat' do
	action [:enable, :start]
end

directory '/tmp/unanet' do
	owner 'tomcat'
	group 'tomcat'
	mode '0755'
	action :create
end

directory '/tmp/unanet/temp' do
	owner 'tomcat'
	group 'tomcat'
	mode '0755'
	action :create
end
=begin
#regex = "JAVA_OPTS='${JAVA_OPTS} -Xms128m -Xmx512m -Djava.awt.headless=true' "
regex = "%r{JAVA_OPTS='\$\{JAVA_OPTS\}\s-Xms128m\s-Xmx512m\s-Djava.awt.headless=true'}"
with = "JAVA_OPTS='${JAVA_OPTS} -Xms128m -Xmx512m -Djava.awt.headless=true' "
ruby_block 'insert_line' do
	block do
		file = Chef::Util::FileEdit.new("/etc/tomcat/tomcat.conf")
		file.insert_line_if_no_match(regex, with)
		file.write_file
	end
end
=end
#set tomcat conf file settings once...
execute "tomcat_java_conf_settings" do
	command 'echo "JAVA_OPTS=\'\${JAVA_OPTS} -Xms128m -Xmx512m -Djava.awt.headless=true\' " | sudo tee -a /etc/tomcat/tomcat.conf && touch /tmp/unanet/tomcat_java_conf.txt' 
	creates "/tmp/unanet/tomcat_java_conf.txt"
	action :run
end




