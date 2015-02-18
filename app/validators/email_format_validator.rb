class EmailFormatValidator < ActiveModel::EachValidator

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def validate_each(object, attribute, value)
    unless value =~ EMAIL_REGEX
      object.errors[attribute] <<
        (options[:message] || "not formatted properly!")
    end
    object.errors
  end

end
