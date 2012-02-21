require 'spec_helper'

describe "meetup_topics/edit.html.erb" do
  before(:each) do
    @meetup_topic = assign(:meetup_topic, stub_model(MeetupTopic,
      :id => 1,
      :urlkey => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit meetup_topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meetup_topics_path(@meetup_topic), :method => "post" do
      assert_select "input#meetup_topic_id", :name => "meetup_topic[id]"
      assert_select "input#meetup_topic_urlkey", :name => "meetup_topic[urlkey]"
      assert_select "input#meetup_topic_name", :name => "meetup_topic[name]"
    end
  end
end
