class HelpRequest < ActiveRecord::Base
  belongs_to :student
  belongs_to :ta_user
end
