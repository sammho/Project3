require 'spec_helper'

describe "meetup_topics/show.html.erb" do
  before(:each) do
    @meetup_topic = assign(:meetup_topic, stub_model(MeetupTopic,
      :id => 1,
      :urlkey => "Urlkey",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Urlkey/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
