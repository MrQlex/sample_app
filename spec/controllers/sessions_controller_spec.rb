# encoding: UTF-8
require 'spec_helper'

describe SessionsController do
	render_views
	
	describe "GET 'new'" do
		it "devrait réussir" do
      	get :new
      	response.should be_success
		end
    
		it "devrait avoir le bon titre" do
			get :new
			response.should have_selector("title", :content => "S'identifier")
		end
	end
  
	describe "POST 'create'" do
		describe "invalid signin" do
		
			before(:each) do
				@attr = { :email => "email@example.com", :password => "invalid"}
			end
			
			it "devrait rerendre la page new" do
				post :create, :session => @attr
				response.should render_template('new')
			end
			
			it "devrait avoir le bon titre" do
				post :create, :session => @attr
				response.should have_selector("title", :content => "S'identifier")
			end
			
			it "devrait avoir un message flash" do
				post :create, :session => @attr
				flash.now[:error].should =~ /invalide/i
			end
		end
		
		describe "avec un mail et un mot de passe valides" do
			before(:each) do
				@user = Factory(:user)
				@attr = {:email => @user.email, :password => @user.password }
			end
			
			it "devrait identifier l'utilisateur" do
				post :create, :session => @attr
				
			end
			
			it "devrait renvoyer vers la page d'affichage de l'utilisateur" do
				post :create, :session => @attr
				response.should redirect_to(user_path(@user))
			end
		end
	end

end
