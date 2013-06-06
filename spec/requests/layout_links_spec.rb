﻿require 'spec_helper'

describe "LayoutLinks" do
	it "devrait trouver une page Accueil à '/'" do
		get '/'
		response.should have_selector('title', :content => "Accueil")
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
	
	it "devrait avoir le non lien sur le layout" do
		visit root_path
		click_link "A Propos"
		response.should have_selector('title', :content => "A Propos")
		click_link "Contact"
		response.should have_selector('title', :content => "Contact") 
		click_link "Accueil"
		response.should have_selector('title', :content => "Accueil")
		click_link "Aide"
		response.should have_selector('title', :content => "Aide")
		click_link "Alex"
		response.should have_selector('title', :content => "Inscription")
	end
end
