require File.dirname(__FILE__) + '/../client'
require 'rspec'
require 'rack/test'

# require_relative '../client'

describe 'client' do
  # include Rack::Test::Methods

  before :each do
    User.base_uri = 'http://localhost:4567'
  end

  it 'should get a user' do
    user = User.find_by_name 'paul'
    expect(user['name']).to eq 'paul'
    expect(user['email']).to eq 'paul@pauldix.net'
    expect(user['bio']).to eq 'rubyist'
  end

  it 'should return nil for a user not found' do
    expect(User.find_by_name 'gosling').to be_nil
  end

  it 'should create a user' do
    user = User.create({
                           :name => 'trotter',
                           :email => 'no spam',
                           :password => 'whatev'
                       })
    expect(user['name']).to eq 'trotter'
    expect(user['email']).to eq 'no spam'
    expect(User.find_by_name 'trotter').to eq user
  end

  it 'should update a user' do
    user = User.update 'paul', { :bio => 'rubyist and author' }
    expect(user['name']).to eq 'paul'
    expect(user['bio']).to eq 'rubyist and author'
    expect(User.find_by_name 'paul').to eq user
  end

  it 'should destroy a user' do
    expect(User.destroy 'bryan').to eq true
    expect(User.find_by_name 'bryan').to be_nil
  end

  it 'should verify login credentials' do
    user = User.login 'paul', 'strongpass'
    expect(user['name']).to eq 'paul'
  end

  it 'should return nil with invalid credentials' do
    expect(User.login 'paul', 'wrongpassword').to be_nil
  end
end