# nginx-extras installed?
describe package('nginx-extras') do
 it { should be_installed }
end

# nginx running?
describe port(80) do
  it { should be_listening }
  its('processes') {should include 'nginx'}
end

# server-status module enabled?
describe http('http://localhost/status') do
  its('status') { should cmp 200 }
  its('body') { should match '^Active connections' }
end
