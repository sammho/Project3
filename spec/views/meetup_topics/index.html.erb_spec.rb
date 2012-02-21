require 'spec_helper'

describe "meetup_topics/index.html.erb" do
  before(:each) do
    assign(:meetup_topics, [
      stub_model(MeetupTopic,
        :id => 1,
        :urlkey => "Urlkey",
        :name => "Name"
      ),
      stub_model(MeetupTopic,
        :id => 1,
        :urlkey => "Urlkey",
        :name => "Name"
      )
    ])
  end

  it "renders a list of meetup_topics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Urlkey".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
