class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 25 }

	VALID_PHONE_REGEX = /\A(\(\d{3}\)|\d{3})-?.?\d{3}-?.?\d{4}+\z/i
	validates :phone, presence: true, format: { with: VALID_PHONE_REGEX }, uniqueness: { case_sensitive: false }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
