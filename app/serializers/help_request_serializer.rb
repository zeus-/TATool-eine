class HelpRequestSerializer < ActiveModel::Serializer
  attributes :id, :description, :student_full_name, :student_email

  def student_full_name
    object.student.full_name
  end
  def student_email
    object.student.email
  end

end
