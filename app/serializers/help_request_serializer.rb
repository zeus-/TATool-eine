class HelpRequestSerializer < ActiveModel::Serializer
  attributes :id, :description, :student_full_name

  def student_full_name
    object.student.full_name
  end
end
