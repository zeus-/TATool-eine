require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new student instance variable" do
      get :new
      expect(assigns(:student)).to be_a_new(Student)
    end
  end

  describe "#create" do
    context "valid request" do
      def valid_request
        post :create, {student: {first_name: "Luke",
                              last_name: "Skywalker",
                              email: "skywalker@outlook.com",
                              password: "12345678",
                              password_confirmation: "12345678"}}
      end


      it "creates a new student record in the database" do
        expect { valid_request }.to change { Student.count }.by(1)
      end

      it "redirects to home page" do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it "sets flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "invalid request" do
      def invalid_request
        post :create, {student: {first_name: "Luke",
                              last_name: "Skywalker",
                              email: "luke@sky",
                              password: "12345678",
                              password_confirmation: "12345678"}}
      end

      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change { Student.count }
      end

      it "sets a flash errors message" do
        invalid_request
        expect(flash[:alert]).to be
      end

      it "renders the new page" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

end
