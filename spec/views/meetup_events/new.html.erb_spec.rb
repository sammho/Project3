require 'spec_helper'

describe "meetup_events/new.html.erb" do
  before(:each) do
    assign(:meetup_event, stub_model(MeetupEvent).as_new_record)
  end

  it "renders new meetup_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meetup_events_path, :method => "post" do
    end
  end
end
