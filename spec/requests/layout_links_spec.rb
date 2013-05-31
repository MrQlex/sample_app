require 'spec_helper'

describe "LayoutLinks" do
	it "devrait trouver une page Accueil à '/'" do
		get '/'
		response.should have_selector('title', :content => "Acceuil")
	end
	
	it "devrait trouver une page Contact à '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end
	
	it "devrait trouver une page A propos à '/about'" do
		get '/about'
		response.should have_selector('title', :content => "A Propos")
	end
	
	it "devrait trouver une page Aide à '/help'" do
		get '/help'
		response.should have_selector('title', :content => "Aide")
	end
end
