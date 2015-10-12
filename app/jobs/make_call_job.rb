class MakeCallJob < ActiveJob::Base
  queue_as :make_call

  # Define our Twilio credentials as instance variables for later use
  @@twilio_sid = ENV['TWILIO_ACCOUNT_SID']
  @@twilio_token = ENV['TWILIO_AUTH_TOKEN']
  @@twilio_number = ENV['TWILIO_NUMBER']

  def perform(to, url)
    client = Twilio::REST::Client.new @@twilio_sid, @@twilio_token
    # Connect an outbound call to the number submitted
    call = client.calls.create(
      :from => @@twilio_number,
      :to => to,
      :url => url # Fetch instructions from this URL when the call connects
    )
  end
end
