require 'spec_helper'

describe "meetup_events/show.html.erb" do
  before(:each) do
    @meetup_event = assign(:meetup_event, stub_model(MeetupEvent))
  end

  it "renders attributes in <p>" do
    render
  end
end
