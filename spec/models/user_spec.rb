require 'spec_helper'

describe User do

	before(:each) do
		@attr = { :nom => "Example User", :email => "user@example.com" }
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
end
