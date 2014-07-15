require 'rails_helper'

RSpec.describe User, :type => :model do
  before { @user = User.new(name: "Matias", phone: "787-438-6225", email: "example@email.com", password: "foobar", password_confirmation: "foobar") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:phone) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  # NAME: 
  describe "when name is not present" do 
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long" do 
  	before { @user.name = "a" * 26 }
  	it { should_not be_valid }
  end

  # PHONE:
  describe "when phone format is invalid" do
  	it "should be invalid" do 
  		phone_numbers = ['1-787-438-6225', '11 232 312 2341', '+12 787 483 9274', '(1233)123-1234']
  		phone_numbers.each do |invalid_phone_number|
  			@user.phone = invalid_phone_number
  			expect(@user).to_not be_valid
  		end
  	end
  end

  describe "when phone format is valid" do 
  	it "should be valid" do 
  		phone_numbers = ['234-567-8901', '234.567.8901', '234/567/8901', '(787)-123-1243', '787-123-1234', '787 429 5864', '1231231234']
  		phone_numbers.each do |valid_phone_number|
  			@user.phone = valid_phone_number
  			expect(@user).to be_valid
  		end
  	end
  end

  # EMAIL:
  describe "when email format is invalid" do 
  	it "should be invalid" do 
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com foo@foos..com]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			expect(@user).not_to be_valid
  		end
  	end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do 
  	before do 
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end
  	it { should_not be_valid }
  end

  # PASSWORD
  describe "when password is not present" do
  	before { @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ") }

  	it { should_not be_valid }
	end

	describe "when password does not match confirmation" do 
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "with password that's too short" do 
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do 
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "with valid password" do 
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do 
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be false }
		end
	end

end