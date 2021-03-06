require 'spec_helper'

describe User do

  before { @user = FactoryGirl.build(:example) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:items) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when passowrd is not present" do 
    before do
      @user = User.new(neme: "Example User", email: "user@example.com",
                       password: "", password_confirmation: "")
    end
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before do
      @user = FactoryGirl.create(:user)
      @user.save!
    end
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "item associations" do
    before { @user.save }
    let!(:older_item) do
      FactoryGirl.create(:item, user:@user, created_at: 1.day.ago)
    end
    let!(:newer_item) do
      FactoryGirl.create(:item, user:@user, created_at: 1.hour.ago)
    end

    it "should have the right items in the right order" do
      expect(@user.items.to_a).to eq [newer_item, older_item]
    end

    it "should destroy associated microposts" do
      items = @user.items.to_a
      @user.destroy
      expect(items).not_to be_empty
      items.each do |item|
        expect(Item.where(id: item.id)).not_to be_empty
      end
    end
  end

  describe "star associations" do
    before { @user.save }
    let!(:older_star) do
      FactoryGirl.create(:star, item_id: "a", user:@user, created_at: 1.day.ago)
    end
    let!(:newer_star) do
      FactoryGirl.create(:star, item_id: "b", user:@user, created_at: 1.hour.ago)
    end

    it "should have the right stars in the right order" do
      expect(@user.stars.to_a).to eq [newer_star, older_star]
    end
  end
end
