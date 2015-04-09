require 'rails_helper'

RSpec.describe "visiting the Home page", type: :request do
  let(:home_page) { HomePage.new }
  let!(:user) { valid_user('somebody@somebody.com', 'password') }

  feature "visiting the home page" do
    context "when not logged in" do
      before { home_page.goto }

      it "has a login button" do
        expect(home_page).to have_login_button
      end

      it "does not have a log out button" do
        expect(home_page).not_to have_logout_button
      end
    end

    context "when logged in" do
      before do
        login(user)
        home_page.goto
      end

      it "does not have a login button" do
        expect(home_page).not_to have_login_button
      end

      it "has a logout button" do
        expect(home_page).to have_logout_button
      end

      it "contains a link to the program lists" do
        expect(home_page).to have_programs_link
      end

      it "contains a link for exercise list" do
        expect(home_page).to have_exercises_link
      end
    end
  end
end
