require 'spec_helper'

# the rspec is testing the User class.
describe User do

# before each test (e.g. each "it 'should' section")
# create instance variable @attr that is hash of
# name, email, password, password_confirmation
# instance variable so that can variable can be
# accessed by the tests
  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "changeme",
      :password_confirmation => "changeme"
    }
  end

# the "should ..." string is just a description for humans
  it "should create a new instance given a valid attribute" do
    # .create is .new, .save; .create! is .new, .save! (throws error if saving fails)
    # creates a new user instance using @attr,
    # and error if fails to save
    User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    # => no_email_user.valid? #fails if valid
    # .valid?  checks against your validations within you ActiveRecord
    # model class e.g. "validates :email, presence: true"
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    # %w[a b] => ["a", "b"]   %w is another way of writing an array of strings
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    # for each email address, testing that User.new(...address).valid? is true
    # so would need to write validations in ActiveRecord User model class
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    # for each email address, testing that User.new(...address).valid? is false
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # creates first user with email addy, creates 2nd user with same email
    # checks that the 2nd email address fails validation in User model class
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    # uppercase version of email
    upcased_email = @attr[:email].upcase
    # .merge replaces origin email with uppercase email
    # creating a first user with uppercase email
    User.create!(@attr.merge(:email => upcased_email))
    # the merge above was without exclamation point, so original
    # attr still has lower-case email address
    # creates 2nd user with email address that is identical except different case
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    # before each test in this section a new user, @user will be created
    before(:each) do
      @user = User.new(@attr)
    end

    # respond_to checks that a method exists
    # so it's checking that
    # @user.respond_to?(:password) is true
    # aka that @user.password works
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    # checking that gets something when @user.password_confirmation
    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    # creates a user without a password nor password_confirmation
    # and checks that it should fail validation (in class User model)
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    # creates a password_confirmation that doesn't match password,
    # and checks that this fails validation
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    # creats password that is only 5 characters and checks that it fails
    # validation
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    # before each test create a new user (.new, .save!)
    before(:each) do
      @user = User.create!(@attr)
    end

    # checks that User.encrypted_password method exists
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    # checks that User.encrypted_password does not return 'blank'
    # blank is e.g. '', "", nil, [], {}
    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

end
