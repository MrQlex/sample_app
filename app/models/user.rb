class User < ActiveRecord::Base
  attr_accessible :email, :nom
  
  validate :nom, :presence => true
end
