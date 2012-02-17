require 'spec_helper'

describe "meetup_members/new.html.erb" do
  before(:each) do
    assign(:meetup_member, stub_model(MeetupMember,
      :name => "MyString",
      :user_id => 1,
      :unparsed_json => "MyText",
      :image_url => "MyString",
      :linkedin_url => "MyString",
      :twitter => "MyString",
      :meetup_id => 1
    ).as_new_record)
  end

  it "renders new meetup_member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meetup_members_path, :method => "post" do
      assert_select "input#meetup_member_name", :name => "meetup_member[name]"
      assert_select "input#meetup_member_user_id", :name => "meetup_member[user_id]"
      assert_select "textarea#meetup_member_unparsed_json", :name => "meetup_member[unparsed_json]"
      assert_select "input#meetup_member_image_url", :name => "meetup_member[image_url]"
      assert_select "input#meetup_member_linkedin_url", :name => "meetup_member[linkedin_url]"
      assert_select "input#meetup_member_twitter", :name => "meetup_member[twitter]"
      assert_select "input#meetup_member_meetup_id", :name => "meetup_member[meetup_id]"
    end
  end
end
