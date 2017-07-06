# nginx-extras installed?
describe package('nginx-extras') do
 it { should be_installed }
end

# nginx running?
describe port(80) do
  it { should be_listening }
  its('processes') {should include 'nginx'}
end
