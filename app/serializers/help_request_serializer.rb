class HelpRequestSerializer < ActiveModel::Serializer
  attributes :id, :description, :student_full_name, :student_email, :student_id

  def student_full_name
    object.student.full_name
  end
  def student_email
    object.student.email
  end
  def student_id
    object.student.id
  end

end
