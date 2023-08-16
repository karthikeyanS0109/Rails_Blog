require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(email: 'test@example.com', password: 'password')
      expect(user).to be_valid
    end
  end

  describe 'authentication' do
    let(:user) { User.create(email: 'test@example.com', password: 'password') }

    it 'signs in with valid credentials' do
      sign_in_success = user.valid_password?('password')
      expect(sign_in_success).to be(true)
    end

    it 'does not sign in with invalid credentials' do
      sign_in_success = user.valid_password?('wrong_password')
      expect(sign_in_success).to be(false)
    end

    it 'signs up with valid data' do
      new_user = User.create(email: 'newuser@example.com', password: 'password')
      expect(new_user).to be_valid
    end

    it 'does not sign up with invalid email' do
      invalid_user = User.create(email: 'invalid_email', password: 'password')
      expect(invalid_user).to_not be_valid
    end
  end

end