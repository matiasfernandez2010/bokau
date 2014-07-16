FactoryGirl.define do 
	factory :user do 
		name "Matias Fernandez"
		phone "787 324 3245"
		email "matiasfernandez@me.com"
		password "foobar"
		password_confirmation "foobar"
	end
end