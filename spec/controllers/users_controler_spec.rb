# encoding: UTF-8
require 'spec_helper'

describe UsersController do
	render_views
	
	describe "GET 'show'" do
		
		before(:each) do
			@user = Factory(:user)
		end
		
		it "devrait réussir" do
			get :show, :id => @user
			response.should be_success
		end
		
		it "devrait trouver le bon utilisateur" do
			get :show, :id => @user
			assigns(:user).should == @user
		end
		
		it "devrait avoir le bon titre" do
			get :show, :id => @user
			response.should have_selector("title", :content => @user.nom)
		end
		
		it "devrait inclure le nom de l'utilisateur" do
			get :show, :id => @user
			response.should have_selector("h1", :content => @user.nom)
		end
		
		it "devrait avoir une image de profil" do
			get :show, :id => @user
			response.should have_selector("h1>img", :alt=> @user.nom, :class => "gravatar")
		end
	end
	
	describe "GET 'new'" do

		it "devrait réussir" do
			get 'new'
			response.should be_success
		end
		
		it "devrait avoir le bon titre" do
			get 'new'
			response.should have_selector("title", :content => "Inscription")
		end
		
		it "devrait avoir un champ Nom" do
			get :new
			response.should have_selector("input", :id => "user_nom", :type=>"text")
		end
		it "devrait avoir un champ eMail" do
			get :new
			response.should have_selector("input", :id => "user_email", :type=>"text")
		end
		it "devrait avoir un champ Password" do
			get :new
			response.should have_selector("input", :id => "user_password", :type=>"password")
		end
		it "devrait avoir un champ Password confirmation" do
			get :new
			response.should have_selector("input", :id => "user_password_confirmation", :type=>"password")
		end
	end
	
	describe "POST 'create'" do
		
		describe "échec" do
			
			before(:each) do
				@attr = {:nom=>"", :email=>"", :password=>"", :password_confirmation=>""}
			end
			
			it "ne devrait pas créer d'utilisateur" do
				lambda do
					post :create, :user => @attr
				end.should_not change(User, :count)
			end
			
			it "devrait avoir le bon titre" do
				post :create, :user => @attr
				response.should have_selector("title", :content => "Inscription")
			end
			
			it "devrait rendre la page 'new'" do
				post :create, :user => @attr
				response.should render_template('new')
			end
		end
		
		describe "succès" do
		
			before(:each) do
				@attr={ :nom=>"New User", :email=>"user@example.com", :password=>"foobar", :password_confirmation=>"foobar"}
			end
			
			it "devrait créer un utilisateur" do
				lambda do
					post :create, :user => @attr
				end.should change(User, :count).by(1)
			end
			
			it "devrait rediriger ver la page e l'utilisateur" do
				post :create, :user => @attr
				response.should redirect_to(user_path(assigns(:user)))
			end
			
			it "devrait avoir un message de bien venue" do
				post :create, :user => @attr
				flash[:success].should =~ /Bienvenue dans l'Application Exemple/i
			end
		end
	end
end