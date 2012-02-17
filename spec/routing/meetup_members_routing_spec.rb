require "spec_helper"

describe MeetupMembersController do
  describe "routing" do

    it "routes to #index" do
      get("/meetup_members").should route_to("meetup_members#index")
    end

    it "routes to #new" do
      get("/meetup_members/new").should route_to("meetup_members#new")
    end

    it "routes to #show" do
      get("/meetup_members/1").should route_to("meetup_members#show", :id => "1")
    end

    it "routes to #edit" do
      get("/meetup_members/1/edit").should route_to("meetup_members#edit", :id => "1")
    end

    it "routes to #create" do
      post("/meetup_members").should route_to("meetup_members#create")
    end

    it "routes to #update" do
      put("/meetup_members/1").should route_to("meetup_members#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/meetup_members/1").should route_to("meetup_members#destroy", :id => "1")
    end

  end
end
