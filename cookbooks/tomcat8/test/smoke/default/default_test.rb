# # encoding: utf-8

# Inspec test for recipe tomcat8::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end


# tomcat 8 inspect tests
describe package('tomcat8') do
	it { should be_installed }
end

describe service('tomcat8') do
	it { should be_running }
end

describe port(8080) do
	it { should be_listening }
end

describe file('/etc/tomcat8/tomcat8.conf') do
	it { should exist }
	its(:content) { should match "JAVA_OPTS='${JAVA_OPTS} -Xms128m -Xmx512m -Djava.awt.headless=true' "  }
end


