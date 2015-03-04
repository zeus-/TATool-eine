require 'rails_helper'

RSpec.describe HelpRequest, type: :model do

  def help_request_attributes(new_attributes)
    valid_attributes = {description: "valid desc",
                        ta_user_id: 1,
                        student_id: 2
                          }
    valid_attributes.merge(new_attributes)
  end

  describe "Validation" do
   
    it "requires a description" do
      help_request = HelpRequest.new(help_request_attributes({description: nil}))
      expect(help_request).to be_invalid
    end

  end
 
  describe "Associations" do
   
    it "associates a student with a help request" do
      help_request = HelpRequest.new(help_request_attributes({student_id: 2}))
      expect(help_request.student_id).to eq(2)
    end
    
    it "associates a TA  with a help request" do
      help_request = HelpRequest.new(help_request_attributes({ta_user_id: 1}))
      expect(help_request.ta_user_id).to eq(1)
    end

  end

end
