require 'spec_helper'

describe UserAffinitiesController do

  describe "GET 'calculate_scores'" do
    it "should be successful" do
      get 'calculate_scores'
      response.should be_success
    end
  end

end
