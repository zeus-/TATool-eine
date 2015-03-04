require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  let(:student)       { create(:student)     }
  let(:ta_user)       { create(:ta_user)     }
  let!(:help_request)   { create(:help_request, student: student, ta_user: ta_user) }
  let!(:help_request_1)   { create(:help_request, student: nil) }

  describe "#new" do
    it "renders the new template where users can choose to be a TA or a student" do 
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "#index" do
   context "as a signed in TA" do
    before do 
      login_ta(ta_user)
    end
    it "assigns the @pending_hrs instance variable to include  help requests that are incomplete  " do
      get :index
      expect(assigns(:pending_hrs)).to eq([help_request])
    end
    
    it "renders the index template" do 
      get :index
      expect(response).to render_template(:index)
    end
  end
  
   context "as a non-logged in ta" do
    it "renders the student index template" do 
      get :student_index
      expect(response).to redirect_to(login_as_student_path)
    end
   end
  end

  describe "#student_index" do
    context " as a logged in student" do 
      before do 
        login(student)
      end
       it "assigns ta_users instance variable to include a help request's TA user id  " do
        help_request
        get :index
        expect(TaUser.all.map(&:id)).to include(help_request.ta_user.id)
      end
  
      it "renders the student index template" do 
        get :student_index
        expect(response).to render_template(:student_index)
      end
    end

   context "as a non-logged in student" do
    it "renders the student index template" do 
      get :student_index
      expect(response).to redirect_to(login_as_student_path)
    end
   end
  end
 
end
