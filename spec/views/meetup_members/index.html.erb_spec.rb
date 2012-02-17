require 'spec_helper'

describe "meetup_members/index.html.erb" do
  before(:each) do
    assign(:meetup_members, [
      stub_model(MeetupMember,
        :name => "Name",
        :user_id => 1,
        :unparsed_json => "MyText",
        :image_url => "Image Url",
        :linkedin_url => "Linkedin Url",
        :twitter => "Twitter",
        :meetup_id => 1
      ),
      stub_model(MeetupMember,
        :name => "Name",
        :user_id => 1,
        :unparsed_json => "MyText",
        :image_url => "Image Url",
        :linkedin_url => "Linkedin Url",
        :twitter => "Twitter",
        :meetup_id => 1
      )
    ])
  end

  it "renders a list of meetup_members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Linkedin Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
