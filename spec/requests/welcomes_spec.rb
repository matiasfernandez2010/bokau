require 'rails_helper'

RSpec.describe "Home page", :type => :request do 
	subject { page }
	before { visit root_path }

	it { should have_selector('h1', text: 'bokau') }
	it { should have_title("bokau | Gourmet delivery, FAST.") }
end