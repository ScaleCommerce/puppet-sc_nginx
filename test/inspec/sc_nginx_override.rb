# test www.example-override.com vhost/server
describe http('http://127.0.0.1/', headers: {Host: 'www.example-override.com'}) do
  its('status') { should eq 200 }
  its('body') { should eq 'test: www.example-override.com' }
end
