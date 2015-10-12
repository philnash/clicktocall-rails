require 'test_helper'

class MakeCallJobTest < ActiveJob::TestCase
  test "should initiate a call with the given phone number and url" do
    twilio_number = '15008675309'
    to_number = '12066505813'
    url = 'http://test.host/connect'
    client = Minitest::Mock.new
    calls = Minitest::Mock.new
    calls.expect(:create, true, [{:from => twilio_number, :to => to_number, :url => url}])
    client.expect(:calls, calls)
    MakeCallJob.class_variable_set(:@@twilio_number, twilio_number)
    Twilio::REST::Client.stub :new, client do
      assert MakeCallJob.new.perform(to_number, url)
    end
    client.verify
    calls.verify
  end
end
