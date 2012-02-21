require "spec_helper"

describe MeetupTopicsController do
  describe "routing" do

    it "routes to #index" do
      get("/meetup_topics").should route_to("meetup_topics#index")
    end

    it "routes to #new" do
      get("/meetup_topics/new").should route_to("meetup_topics#new")
    end

    it "routes to #show" do
      get("/meetup_topics/1").should route_to("meetup_topics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/meetup_topics/1/edit").should route_to("meetup_topics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/meetup_topics").should route_to("meetup_topics#create")
    end

    it "routes to #update" do
      put("/meetup_topics/1").should route_to("meetup_topics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/meetup_topics/1").should route_to("meetup_topics#destroy", :id => "1")
    end

  end
end
