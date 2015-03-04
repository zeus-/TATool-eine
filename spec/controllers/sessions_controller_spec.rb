require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:student) { create(:student) }
  let(:ta_user) { create(:ta_user) }

  describe "#new_student" do
    it "sets a new student instance" do
      get :new_student
      expect(assigns(:user)).to be_a_new Student
    end

    it "renders a new page" do
      get :new_student
      expect(response).to render_template(:new_student)
    end
  end
  
  describe "#new_ta_user" do
    it "sets a new Ta instance" do
      get :new_ta_user
      expect(assigns(:ta_user)).to be_a_new TaUser
    end

    it "renders a new page" do
      get :new_ta_user
      expect(response).to render_template(:new_ta_user)
    end
  end

  describe "#create" do
    context "successful login as a student" do

      def valid_student_request
        post :create, student: {email: student.email,
                             password: student.password}
      end

      it "sets the student_id session variable" do
        valid_student_request
        expect(session[:student_id]).to eq(student.id)
      end

      it "redirects to home page" do
        valid_student_request
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        valid_student_request
        expect(flash[:notice]).to be
      end
    end
    
    context "successful login as a ta" do

      def valid_ta_request
        post :create, ta_user: {email: ta_user.email,
                             password: ta_user.password}
      end

      it "sets the ta_id session variable" do
        valid_ta_request
        expect(session[:ta_user_id]).to eq(ta_user.id)
      end

      it "redirects to TA's index page" do
        valid_ta_request
        expect(response).to redirect_to(home_index_path)
      end

      it "sets a flash message" do
        valid_ta_request
        expect(flash[:notice]).to be
      end
    end

    context "unsuccessful login as a student" do

      def invalid_student_request
        post :create, student: {email: student.email,
                             password: student.password + "x"}
      end

      it "doesn't set the session student_id variable" do
        invalid_student_request
        expect(session[:student_id]).not_to be
      end

      it "renders the new template" do
        invalid_student_request
        expect(response).to render_template(:new_student)
      end

      it "creates a flash alert message" do
        invalid_student_request
        expect(flash[:alert]).to be
      end
    end
    context "unsuccessful login as a TA" do

      def invalid_ta_request
        post :create, ta_user: {email: ta_user.email,
                             password: ta_user.password + "x"}
      end

      it "doesn't set the session ta_id variable" do
        invalid_ta_request
        expect(session[:ta_user_id]).not_to be
      end

      it "renders the new template" do
        invalid_ta_request
        expect(response).to render_template(:new_ta_user)
      end

      it "creates a flash alert message" do
        invalid_ta_request
        expect(flash[:alert]).to be
      end
    end

  end

  describe "#destroy" do
    before do
      login(student)
      delete :destroy
    end

    it "removes the session student_id variable" do
      expect(session[:student_id]).not_to be
    end

    it "redirects to the home page" do
      expect(response).to redirect_to(root_path)
    end

    it "sets a flash message" do
      expect(flash[:notice]).to be
    end
  end
  describe "#destroy_ta" do
    before do
      login(ta_user)
      delete :destroy
    end

    it "removes the session ta_id variable" do
      expect(session[:ta_user_id]).not_to be
    end

    it "redirects to the home page" do
      expect(response).to redirect_to(root_path)
    end

    it "sets a flash message" do
      expect(flash[:notice]).to be
    end
  end
end
