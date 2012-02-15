require "spec_helper"

describe MeetupEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/meetup_events").should route_to("meetup_events#index")
    end

    it "routes to #new" do
      get("/meetup_events/new").should route_to("meetup_events#new")
    end

    it "routes to #show" do
      get("/meetup_events/1").should route_to("meetup_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/meetup_events/1/edit").should route_to("meetup_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/meetup_events").should route_to("meetup_events#create")
    end

    it "routes to #update" do
      put("/meetup_events/1").should route_to("meetup_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/meetup_events/1").should route_to("meetup_events#destroy", :id => "1")
    end

  end
end
