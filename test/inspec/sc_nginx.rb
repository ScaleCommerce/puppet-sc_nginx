# nginx-extras installed?
describe package('nginx-extras') do
 it { should be_installed }
end

# nginx running?
describe port(80) do
  it { should be_listening }
  its('processes') {should include 'nginx'}
end

# nginx running in supervisor?
describe command('supervisorctl status nginx') do
  its('stdout') { should match 'RUNNING'}
end

# server-status module enabled?
describe http('http://localhost/status') do
  its('status') { should cmp 200 }
  its('body') { should match '^Active connections' }
end

# test default vhost/server
describe http('http://localhost/') do
  its('status') { should eq 200 }
  its('body') { should eq 'test: default' }
end

# test www.example.com vhost/server
describe http('http://127.0.0.1/', headers: {Host: 'www.example.com'}) do
  its('status') { should eq 200 }
  its('body') { should eq 'test: www.example.com' }
end

# test custom-port-9200 vhost/server
describe http('http://127.0.0.1:9200/', headers: {Host: 'custom-port-9200'}) do
  its('status') { should eq 200 }
  its('body') { should eq 'test: custom-port-9200' }
end

# test proxy location
describe http('http://127.0.0.1/', headers: {Host: 'proxy-source'}) do
  its('status') { should eq 200 }
  its('body') { should eq 'test: proxy-target' }
end
