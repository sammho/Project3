require 'spec_helper'

describe "meetup_members/show.html.erb" do
  before(:each) do
    @meetup_member = assign(:meetup_member, stub_model(MeetupMember,
      :name => "Name",
      :user_id => 1,
      :unparsed_json => "MyText",
      :image_url => "Image Url",
      :linkedin_url => "Linkedin Url",
      :twitter => "Twitter",
      :meetup_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Linkedin Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Twitter/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
