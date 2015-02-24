class HelpRequest < ActiveRecord::Base
  validates_presence_of :description
  belongs_to :student
  belongs_to :ta_user

  def as_json(*args)
    super.merge(student: student)
  end
end
