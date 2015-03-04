require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  describe "Signing in student" do
    let(:student) { create(:student) }

    it "redirects the student to the home page" do
      visit login_as_student_path
      fill_in "Email", with: student.email
      fill_in "Password", with: student.password
      click_button "Sign In"
      expect(current_path).to eq(root_path)
    end

    it "redirects to login after sign out" do
      login_via_web(student)
      click_on "Sign Out"
      expect(current_path).to eq(login_as_student_path)
    end
  end
  
  describe "authenticating TA user" do
    let!(:ta) { create(:ta_user) }

    it "redirects the ta to the ta index page upon sign in" do
      visit login_as_ta_path
      fill_in "Email", with: ta.email
      fill_in "Password", with: ta.password
      click_button "Sign In"
      expect(current_path).to eq(home_index_path)
    end
    
    it "redirects to login after sign out" do
      ta_login_via_web(ta)
      click_on "Sign Out"
      expect(current_path).to eq(login_as_ta_path)
    end

  end
end
