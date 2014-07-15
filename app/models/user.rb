class User < ActiveRecord::Base
	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { maximum: 25 }

	VALID_PHONE_REGEX = /\A(\(\d{3}\)|\d{3})-?.?\d{3}-?.?\d{4}+\z/i
	validates :phone, presence: true, format: { with: VALID_PHONE_REGEX }, uniqueness: { case_sensitive: false }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+(?<!\.)\.(?!\.)[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }
end
