require 'spec_helper'

describe "meetup_events/index.html.erb" do
  before(:each) do
    assign(:meetup_events, [
      stub_model(MeetupEvent),
      stub_model(MeetupEvent)
    ])
  end

  it "renders a list of meetup_events" do
    render
  end
end
