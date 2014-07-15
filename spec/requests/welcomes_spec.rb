require 'rails_helper'

describe "Home page" do 
	subject { page }
	before { visit root_path }

	it { should have_selector('h1', text: 'bokau') }
	it { should have_title("bokau | Gourmet delivery, FAST.") }

end