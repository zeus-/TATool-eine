require 'rails_helper'

RSpec.describe TaUser, type: :model do
  def ta_user_attributes(new_attributes = {})
    valid_attributes = {first_name: "Yoda",
                        last_name: "Da-Man",
                        email: "yoda@gmail.com",
                        password: "12345678"}
    valid_attributes.merge new_attributes
  end

  describe "Validations" do
    it "requires an email" do
      ta_user = TaUser.new ta_user_attributes({email: nil})
      expect(ta_user).to be_invalid
    end

    it "requires an unique email" do
      TaUser.create(ta_user_attributes)
      ta_user = TaUser.new(ta_user_attributes)
      expect(ta_user).to be_invalid
    end

    it "requires an email with a valid format" do
      ta_user = TaUser.new(ta_user_attributes({email: "bob@gmail"}))
      expect(ta_user).to be_invalid
    end
  end

  describe ".full_name" do
    it "returns concatenated first and last names if given" do
      ta_user = TaUser.new(ta_user_attributes)
      full_name = "#{ta_user_attributes[:first_name]} #{ta_user_attributes[:last_name]}"
      expect(ta_user.full_name).to eq(full_name)
    end

    it "returns email if first and last names are not given" do
      ta_user = TaUser.new(ta_user_attributes({first_name: nil, 
                                       last_name:  nil}))
      expect(ta_user.full_name).to eq(ta_user_attributes[:email])
    end
  end

  describe "Hashing the password" do
    it "generate password digest when given password" do
      ta_user = TaUser.new ta_user_attributes
      ta_user.save
      expect(ta_user.password_digest).to be
    end

  end


end
