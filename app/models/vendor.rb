class Vendor < ApplicationRecord

	attr_accessor :validate_login_form_req

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :business_name, presence: true, :if => :validate_login_form_name?
    validates :password, length: { minimum: 4, maximum: 16 }
    has_secure_password
    validates :email, format: { with: VALID_EMAIL_REGEX, message: 'must contain a valid email address.!' }
    validates :name, presence: true, :if => :validate_login_form_name?

    private
	  def validate_login_form_name?
	    !self.validate_login_form_req # true = run validation, false = skip validation
	  end
    
end
