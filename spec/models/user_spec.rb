require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    #it must be created with a password and password_confirmation fields
    #have an exmple where they do not match
    #have an example where they match
    #emails should be unique, not case-sensitive
    #email, first name and last name should be required

    #password should have min length

    before do
    @user = User.new(first_name: 'Pleb', last_name: 'Johnson', email: 'pleb@pjohns.com', password: 'peejees', password_confirmation: 'peejees')
    end
    it "should successfully create a user when all required fields are present" do
      @user.save
      expect(@user).to be_valid
    end
    
    it "should not create a user without an email" do
      @user.email = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "should not create a user without an first name" do
      @user.first_name = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it "should not create a user without an last name" do
      @user.last_name = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it "should not create a user if password and password_confirmation do not match" do
      @user.password_confirmation = 'peppathepig'
      @user.save
      # puts @user.errors.full_messages
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
