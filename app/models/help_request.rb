class HelpRequest < ActiveRecord::Base
  validates_presence_of :description
  belongs_to :student
  belongs_to :ta_user
end
