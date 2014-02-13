require 'spec_helper'

describe PreferencesController do

  describe "GET 'student_preference'" do
    it "returns http success" do
      get 'student_preference'
      response.should be_success
    end
  end

  describe "GET 'sponsor_preference'" do
    it "returns http success" do
      get 'sponsor_preference'
      response.should be_success
    end
  end

end
