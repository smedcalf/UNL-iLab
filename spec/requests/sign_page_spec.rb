require 'spec_helper'

describe "Sign up" do
  before do
    visit register_path
  end

  describe "The first user" do
    before do
      fill_in "Username", with: "admin"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_button "Submit"
    end

    it "should be able to sign up" do
      expect(page).to have_content("Logout")
    end

    it "should be an admin (instructor)" do
      expect(page).to have_content("Account has been created and you are set to an instructor(admin)")
    end
  end

  describe "A second user" do
    let!(:admin) { FactoryGirl.create(:user) }

    before do
      fill_in "Username", with: "student"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_button "Submit"
    end

    it "should be able to sign up" do
      expect(page).to have_content("Logout")
    end

    it "should not be an admin" do
      expect(page).to have_content("Congratulations!!! Your account has been created!")
    end
  end
end
