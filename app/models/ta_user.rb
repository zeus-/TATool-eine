class TaUser < ActiveRecord::Base
  has_secure_password
  has_many :help_requests, dependent: :nullify
  has_many :open_help_requests, -> { where(is_complete: false) }, class_name: 'HelpRequest'

  validates :email, presence: true, uniqueness: true,
            email_format: true

  scope :available, -> { where(is_available: true) }

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
end
