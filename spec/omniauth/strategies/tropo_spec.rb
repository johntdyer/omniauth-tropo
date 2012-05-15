require File.expand_path('../../../spec_helper', __FILE__)

RESPONSE_JSON = <<-EOF
{
  "href": "http://api.tropo.com/users/jdyer",
  "id": "12345",
  "address": "189 South Orange Avenue",
  "address2": "#1000",
  "city": "Orlando",
  "country": "USA",
  "email": "user@test.com",
  "firstName": "John",
  "jobTitle": "System Engineer",
  "joinDate": "2008-04-05T19:57:49.643+0000",
  "lastName": "Dyer",
  "marketingOptIn": true,
  "organization": "Voxeo Labs",
  "notes": "foo",
  "phoneNumber": "1234567890",
  "postalCode": "32801",
  "state": "FL",
  "username": "jdyer",
  "status": "active"
}
EOF

describe OmniAuth::Strategies::Tropo do
  def app; lambda {|env| [200, {}, ["Hello HttpBasic!"]]}; end

  let(:fresh_strategy) { Class.new OmniAuth::Strategies::Tropo }
  let(:instance) { subject.new(app, "http://www.example.com/rest")}
  subject { fresh_strategy }

  it 'should be initialized with API endpoint' do
    instance.options.endpoint.should == "http://www.example.com/rest"
  end

  it 'should set an expected auth hash' do
    json = MultiJson.load(RESPONSE_JSON, :symbolize_keys => true)
    instance.stub!(:request).and_return({'username' => 'jdyer', 'password' => '1234'})
    instance.stub!(:json_response).and_return(json)
    instance.uid.should                     == '12345'
    instance.credentials[:username].should  == 'jdyer'
    instance.info[:name].should             == 'John Dyer'
    instance.extra[:job_title].should       == 'System Engineer'
    instance.extra[:state].should           == 'FL'
    instance.extra[:zip_code].should        == '32801'
    instance.extra[:number].should          == '1234567890'
    instance.extra[:email].should           == 'user@test.com'
    instance.extra[:address].should         == '189 South Orange Avenue'
    instance.extra[:address2].should        == '#1000'
  end
end
