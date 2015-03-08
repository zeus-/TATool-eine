require 'rails_helper'

RSpec.feature "TaHelpRequests", type: :feature, js: true do
  
  describe "Listing HelpRequests for TA's" do
    let(:student) { create(:student) }
    let(:ta) { create(:ta_user, is_available: true) }
    before { ta_login_via_web(ta) } 
    before { visit home_index_path }
    
    it "displays a welcome message" do
      expect(page).to have_text "Jedi"
    end

    it "displays a title for the page" do
      expect(page).to have_title "TATool-eine"
    end
    
    it "displays a the name of the TA" do
      expect(page).to have_text "#{ta.first_name}"
    end
    
    it "displays a the offline/online button" do
      expect(page).to have_css "button.offline" || "button.online"
    end

    context "with pending  help request"  , js: true do
      let!(:hr)   { create(:help_request, student: student, ta_user: ta) }
    
      it "displays the main title" do
        expect(page).to have_text /Your Jedi Dashboard/i
      end
      
      it "displays hr's desc" do
        expect(page).to have_text /#{hr.description}/i
      end

      it "displays hr description in p elements"  do
        expect(page).to have_selector "p", hr.description
      end
      
      it "displays the student's name with a help request" do
        expect(page).to have_text /#{hr.student.first_name}/i
      end

      it "displays an icon to mark a hr as done" do
        expect(page).to have_selector "i.fa.fa-check-square-o"
      end
    end
  end
  
  describe "marking a hr as done" do
    let(:student) { create(:student) }
    let(:ta) { create(:ta_user, is_available: true) }
    let!(:hr) { create(:help_request, ta_user: ta, student: student) }
    let!(:hr_1) { create(:help_request, ta_user: ta, student: student, is_complete: true) }
    before { ta_login_via_web(ta) } 
    before { visit home_index_path }
      it "marks the hr as done" do
        
        click_button "checkbox"
        visit home_index_path 
        expect(hr.reload.is_complete).to eq(true)
      end
    
      it "adds hr to completed requests upon marking as done" do
        click_button "undo"
        visit home_index_path   
        expect(hr_1.reload.is_complete).to eq(false)
      end
  end
end
