require 'rails_helper'

RSpec.feature "HelpRequests", type: :feature do
  describe "Home Page / Listing HelpRequests" do
  let(:student) { create(:student) }
  before { login_via_web(student) } 
    it "displays a welcome message" do
      visit root_path 
      expect(page).to have_text "Hello apprentice"
    end

    it "displays a title for the page" do
      visit root_path
      expect(page).to have_title "TATool-eine"
    end

    context "with help_requests" do
      let!(:hr)   { create(:help_request) }
      let!(:hr_1) { create(:help_request) }

      it "displays hr description in p elements" , js: true do
        visit root_path
         expect(page).to have_selector "p", hr_1.description
      end

    end
  end

end
