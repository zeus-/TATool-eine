require 'rails_helper'

RSpec.describe TaHelpRequestsController, type: :controller do

  let!(:ta_user)         { create(:ta_user)     }
  let!(:help_request)   { create(:help_request, ta_user: ta_user) }
  let!(:help_request_1) { create(:help_request, student: nil) }

  describe "#index" do
    it "assigns the @pending_hrs instance variable to include  help requests that are incomplete  " do
      login_ta(ta_user)
      get :index
      expect(assigns(:pending_hrs)).to eq([help_request])
    end

  end

  describe "#complete_requests" do
  let!(:completed_help_request)   { create(:help_request, ta_user: ta_user, is_complete: true) }
     it "assigns the @complete_hrs instance variable to include  help requests that are incomplete  " do
      login_ta(ta_user)
      get :complete_requests
      expect(assigns(:complete_hrs)).to eq([completed_help_request])
    end
  end

  describe "#update" do
    context "with signed in TA" do
      before { login(ta_user) }
        context "with valid request" do
          before do
            patch :update, id: help_request.id, help_request: {is_complete: true, ta_user: ta_user}
          end
          
          #it "changes is_complete boolean when marked as done" do
          #  expect(help_request.reload.is_complete).to eq(true)
          #end
        end

        context "with invalid params" do
          before { patch :update, id: help_request.id, help_request: {is_complete: " " } }

          it "doesn't change the database" do
            expect(help_request.reload.description).not_to eq(" ")
          end
        end
      
      context "with no TA signed in" do
        before do
          patch :update, id: help_request_1.id, help_request: {is_complete: true}
        end
          
        it "throws an error" do
          expect { response }.to_not change{ help_request_1.updated_at }
        end
      end
    
    end
  end

  describe "#destroy" do
    let!(:help_request)   { create(:help_request, ta_user: ta_user) }
    before { login(ta_user) }
    context "deleting a help_request that belongs to the according TA" do
     # it "deletes the help_request from the database" do
      #  expect { delete :destroy, id: help_request.id }.to change { HelpRequest.count }.by(-1)
    #  end
    end

    context "with no ta signed in" do
      it "throws an error" do
        expect { delete :destroy, id: help_request_1.id }.to_not change{ HelpRequest.count }
      end
    end
  end
  
end
