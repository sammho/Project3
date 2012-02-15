require 'spec_helper'

describe "meetup_events/edit.html.erb" do
  before(:each) do
    @meetup_event = assign(:meetup_event, stub_model(MeetupEvent))
  end

  it "renders the edit meetup_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meetup_events_path(@meetup_event), :method => "post" do
    end
  end
end
