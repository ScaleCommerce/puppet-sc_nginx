# nginx-extras installed?
describe package('nginx-extras') do
 it { should be_installed }
end

# nginx running?
describe service('nginx') do
 it { should be_running }
end
describe port(80) do
  it { should be_listening }
  its('processes') {should include 'nginx'}
end
