require 'rails_helper'

RSpec.describe Student, type: :model do
  def student_attributes(new_attributes = {})
    valid_attributes = {first_name: "Luke",
                        last_name: "Skywalker",
                        email: "luke@gmail.com",
                        password: "12345678"}
    valid_attributes.merge new_attributes
  end

  describe "Validations" do
    it "requires an email" do
      student = Student.new student_attributes({email: nil})
      expect(student).to be_invalid
    end

    it "requires an unique email" do
      Student.create(student_attributes)
      student = Student.new(student_attributes)
      expect(student).to be_invalid
    end

    it "requires an email with a valid format" do
      student = Student.new(student_attributes({email: "bob@gmail"}))
      expect(student).to be_invalid
    end
  end

  describe ".full_name" do
    it "returns concatenated first and last names if given" do
      student = Student.new(student_attributes)
      full_name = "#{student_attributes[:first_name]} #{student_attributes[:last_name]}"
      expect(student.full_name).to eq(full_name)
    end

    it "returns email if first and last names are not given" do
      student = Student.new(student_attributes({first_name: nil, 
                                       last_name:  nil}))
      expect(student.full_name).to eq(student_attributes[:email])
    end
  end

  describe "Hashing the password" do
    it "generate password digest when given password" do
      student = Student.new student_attributes
      student.save
      expect(student.password_digest).to be
    end

  end


end
