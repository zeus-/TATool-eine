require 'rails_helper'

RSpec.feature "HelpRequests", type: :feature do
  describe "Home Page / Listing HelpRequests for students" do
  let(:student) { create(:student) }
  let(:ta) { create(:ta_user, is_available: true) }
  before { login_via_web(student) } 
    it "displays a welcome message" do
      visit root_path 
      expect(page).to have_text "Hello apprentice"
    end

    it "displays a title for the page" do
      visit root_path
      expect(page).to have_title "TATool-eine"
    end

    context "with created help request"  , js: true do
      let!(:hr)   { create(:help_request, student: student, ta_user: ta) }
      let!(:hr_1) { create(:help_request) }
      before { visit root_path }
    
      it "displays the main title" do
        expect(page).to have_text /AVAILABLE TEACHING ASSISTANTS/i
      end
      
      it "displays the date in the main title" do
        expect(page).to have_text /#{I18n.t("date.abbr_month_names")[Date.today.month].upcase + Date.today.strftime(" %d %Y")}/i
      end

      it "displays hr's desc" do
        expect(page).to have_text /#{hr.description}/i
      end
      
      it "displays available ta's" do
        expect(page).to have_text /#{ta.first_name}/i
      end

      it "displays hr description in p elements"  do
        expect(page).to have_selector "p", hr_1.description
      end
      
      it "displays the student's name with a help request" do
        expect(page).to have_text /#{hr.student.first_name}/i
      end

      it "displays a button to delete a request" do
        expect(page).to have_selector "button"
      end
    end
  end

  describe "creating a hr"
    context "as an authorized student"  , js: true do
      let(:student) { create(:student) }
      let!(:ta) { create(:ta_user, is_available: true) }
      before { login_via_web(student) } 
      before { visit root_path }
      it "creates an hr" do

        fill_in "description", with: "help me"
        click_button "Submit Help Request"
        
        visit root_path 
        expect(current_path).to eq(root_path)
        expect(HelpRequest.count).to eq(1)
        expect(page).to have_text /help me/i
      end
      it "creates a request for the associated ta" do
        fill_in "description", with: "help me"
        click_button "Submit Help Request"
        
        visit root_path 
        expect(ta.help_requests.count).to eq(1)
      end
      it "deletes a request when clicking on delete button" do
        fill_in "description", with: "help me"
        click_button "Submit Help Request"
        
        visit root_path 
        click_button "trash" 
        visit root_path 
        expect(HelpRequest.count).to eq(0)

      end
    end 
    context "as an unauthorized student" do 
      before { visit root_path }
      it "redirects back to login" do
        expect(current_path).to eq(login_as_student_path)
        expect(page).to have_text /log in young padawan/i
    end
  end

end
