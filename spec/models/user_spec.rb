require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
  
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
    it "should not create a user without a password" do
      @user.password = nil
      @user.save
      puts @user.errors.full_messages
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "should not create a user if password and password_confirmation do not match" do
      @user.password_confirmation = 'peppathepig'
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should not create a user if the email already exists in the database" do
      @user.save
      @new_user = User.new(first_name: 'Plebie', last_name: 'Johnson', email: 'pleb@pjohns.com', password: 'peejees2', password_confirmation: 'peejees2')
      @new_user.save
      expect(@new_user).not_to be_valid
      expect(@new_user.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe 'Password Length between 5 and 10 characters' do
    before do
      @user = User.new(first_name: 'Pleb', last_name: 'Johnson', email: 'pleb@pjohns.com', password: 'peejees', password_confirmation: 'peejees')
      end
      it "should not create a user if password length < 5" do
        @user.password = 'peep'
        @user.password_confirmation = 'peep'
        @user.save
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end
      it "should not create a user if password length > 10" do
        @user.password = 'peep1234567'
        @user.password_confirmation = 'peep1234567'
        @user.save
        puts @user.errors.full_messages
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 10 characters)")
      end
  end
end
