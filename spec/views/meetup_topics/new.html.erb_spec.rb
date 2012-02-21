require 'spec_helper'

describe "meetup_topics/new.html.erb" do
  before(:each) do
    assign(:meetup_topic, stub_model(MeetupTopic,
      :id => 1,
      :urlkey => "MyString",
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new meetup_topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meetup_topics_path, :method => "post" do
      assert_select "input#meetup_topic_id", :name => "meetup_topic[id]"
      assert_select "input#meetup_topic_urlkey", :name => "meetup_topic[urlkey]"
      assert_select "input#meetup_topic_name", :name => "meetup_topic[name]"
    end
  end
end
