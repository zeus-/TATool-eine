require 'rails_helper'

RSpec.describe HelpRequestsController, type: :controller do

  let(:student)       { create(:student)     }
  let(:ta_user)       { create(:ta_user)     }
  let!(:help_request)   { create(:help_request, student: student, ta_user: ta_user) }
  let!(:help_request_1)   { create(:help_request, student: nil) }

  describe "#create" do
    context "with signed in student" do
      before { login(student) }

      context "with valid parameters" do
        def valid_request
          post :create, {help_request: {
                            description: "valid descritpion"}}
        end
        it "adds a help_request to the database for current student" do
          expect { valid_request }.to change { student.help_requests.count }.by(1)
        end
      end
       
      context "with invalid parameters" do
        def invalid_request
          post :create, {help_request: {
                            description: " "}}
        end
        it "doesn't create a record in the database" do
          expect { invalid_request }.not_to change {HelpRequest.count}
        end
        it "renders the index template" do
          invalid_request
          expect(response).to render_template(:index)
        end
      end
    end
    context "with no signed in student" do
      it "doesnt change the database" do
        expect {
        post :create, help_request: {description: "valid"}
        }.not_to change {HelpRequest}
      end
    end
  end

  describe "#index" do
    it "assigns ta_users instance variable to include a help request's TA user id  " do
      help_request
      get :index
      expect(TaUser.all.map(&:id)).to include(help_request.ta_user.id)
    end
  end


  describe "#update" do
    context "with signed in student" do
      before { login(student) }
      context "with owner signed in" do
        context "with valid request" do
          before do
            patch :update, id: help_request.id, help_request: {description: "help me!"}
          end
          
          it "changes the description of the help_request if it's different" do
            expect(help_request.reload.description).to eq("help me!")
          end
        end

        context "with invalid params" do
          before { patch :update, id: help_request.id, help_request: {description: ""} }

          it "renders the index page" do
            expect(response).to render_template(:index)
          end

          it "doesn't change the database" do
            expect(help_request.reload.description).not_to eq(" ")
          end
        end
      end
      
      context "with non owner signed in" do
        before do
          patch :update, id: help_request_1.id, help_request: {description: "help mei!"}
        end
          
        it "throws an error" do
          expect { response }.to_not change{ help_request_1.updated_at }
        end
      end
    end

    context "with no signed in student" do
      it "doesnt change the database" do
        expect {
          patch :update, id: help_request_1.id, help_request: {description: "help mei!"}
        }.not_to change {HelpRequest}
      end
    end

  end

  describe "#destroy" do
    let!(:help_request)   { create(:help_request, student: student) }
    before { login(student) }
    context "deleting own help_request" do
      it "deletes the help_request from the database" do
        expect { delete :destroy, id: help_request.id }.to change { HelpRequest.count }.by(-1)
      end
    end

    context "deleting non-owned help_request" do
      it "throws an error" do
        expect { delete :destroy, id: help_request_1.id }.to_not change{ HelpRequest.count }
      end
    end
    context "with no signed in student" do
      it "doesnt change the database" do
        expect {
          delete :destroy, id: help_request.id 
        }.not_to change {HelpRequest}
      end
    end

  end
  
end
