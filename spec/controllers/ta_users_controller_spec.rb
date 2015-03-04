require 'rails_helper'

RSpec.describe TaUsersController, type: :controller do
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new ta_user instance variable" do
      get :new
      expect(assigns(:ta_user)).to be_a_new(TaUser)
    end
  end

  describe "#create" do
    context "valid request" do
      def valid_request
        post :create, {ta_user: {first_name: "Yoda",
                              last_name: "Da-Man",
                              email: "yoda@outlook.com",
                              password: "12345678",
                              password_confirmation: "12345678"}}
      end


      it "creates a new ta_user record in the database" do
        expect { valid_request }.to change { TaUser.count }.by(1)
      end

      it "redirects to home page" do
        valid_request
        expect(response).to redirect_to(home_index_path)
      end

      it "sets flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "invalid request" do
      def invalid_request
        post :create, {ta_user: {first_name: "Yoda",
                              last_name: "Da-Man",
                              email: "yoda@force",
                              password: "12345678",
                              password_confirmation: "12345678"}}
      end

      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change { TaUser.count }
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
