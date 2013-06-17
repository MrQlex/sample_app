require 'spec_helper'

describe User do

	before(:each) do
		@attr = {
			:nom => "Example User",
			:email => "user@example.com",
			:password => "foobar",
			:password_confirmation => "foobar"
		}
	end
	
	it "devrait créer une nouvelle instance dotée des attributs valides" do
		User.create!(@attr)
	end
	
	it "exige un nom"  do
		bad_guy = User.new(@attr.merge(:nom => ""))
		bad_guy.should_not be_valid
	end
	
	it "exige un email"  do
		bad_guy = User.new(@attr.merge(:email => ""))
		bad_guy.should_not be_valid
	end
	
	it "devrait rejeter les noms trops longs" do
		long_nom		= "a" * 51
		long_nom_user = User.new(@attr.merge(:nom => long_nom))
		long_nom_user.should_not be_valid
	end
	
	it "devrait accpeter les adresses valides" do
		adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
		adresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
	end
	
	it "devrait rejeter les adresses invalides" do
		adresses = %w[user@foo user_at_foo.org example.user@foo.]
		adresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should_not be_valid
		end	
	end
	
	it "devrait rejeter un email double" do
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	
	it "devrait rejeter une adresse email invalide jusqu'à la casse" do
		upcased_email = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcased_email))
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	
	describe "password validations" do
		it "devrait exiger un mot de passe" do
			User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
		end

		it "devrait exiger une confirmation" do
			User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
		end
		
		it "devrait rejeter les mots de passe trop courts" do
			short = "a" * 5
			User.new(@attr.merge(:password => short, :password_confirmation => short)).should_not be_valid		
		end
		
		it "devrait rejeter les mots de passes trop longs" do
			long = "a" * 41
			User.new(@attr.merge(:password => long, :password_confirmation => long)).should_not be_valid
		end

	end
	
	describe "password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end
		
		it "devrait avoir un mot de passe encrypte" do
			@user.should respond_to(:encrypted_password)
		end
		
		it "devrait définir un mot de passe crypté" do
			@user.encrypted_password.should_not be_blank
		end
		
		describe "Méthode has_password?" do
			it "doit retrouner true si les mots de passes coincides" do
				@user.has_password?(@attr[:password]).should be_true
			end
			
			it "doit retourner false si les mots de passes diverges" do
				@user.has_password?("invalide").should be_false
			end
		end
		
		describe "authenticate method" do
			it "devrait retourner nul en cas d'inéquation entre email/ mot de passe" do
				wrong_password_user = User.authenticate(@attr[:email],"wrongpass")
				wrong_password_user.should be_nil
			end
			
			it "devrait retourner nil qunad un email ne correspond à aucun utilisateur" do
				nonexistent_user =  User.authenticate("bar@foo.com", @attr[:password])
				nonexistent_user.should be_nil
			end
			
			it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
				matching_user = User.authenticate(@attr[:email], @attr[:password])
				matching_user.should == @user
			end
		end
		
	end
	
	
end
