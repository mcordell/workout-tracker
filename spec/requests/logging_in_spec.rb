require 'rails_helper'

RSpec.describe "Logging In", type: :request do
  let(:login_page) { LoginPage.new }

  feature "visiting the login path" do
    it "prompts user to login" do
      login_page.goto
      expect(login_page).to have_login_prompt
    end
  end

  feature 'signing in with valid credentials' do
    let(:username) { 'somebody@example.com' }
    let(:password) { 'heyapassword' }
    let!(:user) { valid_user(username, password) }

    before { login_page.login username, password }

    it "signs the user in" do
      expect(current_path).to eq root_path
    end

    it "tells the user they logged in successfully" do
      expect(page).to have_css('.alert', 'Signed in successfully.')
    end
  end

  feature 'signing in with invalid credentials' do
    let(:bad_username) { 'thisisnotsomebody@example.com' }
    let(:password) { 'bad pass' }

    before { login_page.login bad_username, password }

    it "does not sign the user in" do
      expect(current_path).not_to eq root_path
    end

    it "warns that the credentials are bad" do
      expect(login_page).to have_bad_login_warning
    end
  end
end
