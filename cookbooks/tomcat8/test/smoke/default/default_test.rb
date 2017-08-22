# # encoding: utf-8

# Inspec test for recipe tomcat8::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('tomcat') do
    it { should exist }
  end
end

# tomcat 8 inspect tests
describe package('tomcat') do
	it { should be_installed }
end

describe service('tomcat') do
	it { should be_running }
end

describe port(8080) do
	it { should be_listening }
end

describe file('/etc/tomcat/tomcat.conf') do
	it { should exist }
	its(:content) { should match (%r{JAVA_OPTS='\$\{JAVA_OPTS\}\s-Xms128m\s-Xmx512m\s-Djava.awt.headless=true'})  }
end


