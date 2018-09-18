class User < ApplicationRecord
   #attr_accessor :id, :email, :password

    attr_accessor :skip_email_reset_password  # defaults to nil (false)
    attr_accessor :skip_confirm_password  # defaults to nil (false)

    before_create { generate_token(:auth_token) }

    has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX, message: 'must contain a valid email address.!' }, :if => :validate_reset_password_form?
    validates :password_confirmation, presence: true, :if => :validate_confirm_pwd?
    #length: { minimum: 4, maximum: 16 }


    def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!
	  UserMailer.password_reset(self).deliver
	end

    def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

    private
	  def validate_reset_password_form?
	    !self.skip_email_reset_password # true = run validation, false = skip validation
	  end

	  def validate_confirm_pwd?
	  	!self.skip_confirm_password
	  end


	

end
