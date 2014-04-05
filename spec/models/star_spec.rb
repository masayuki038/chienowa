require 'spec_helper'

describe Star do

  let(:user) { FactoryGirl.create(:user) }
  before { @star = FactoryGirl.build(:star, user: user) }

  subject { @star }

  it { should respond_to(:site_id) }
  it { should respond_to(:item_id) }
  it { should respond_to(:url) }
  it { should respond_to(:user) }
  it { should respond_to(:comment) }

  it { should be_valid }

  describe "when site_id is not present" do
    before { @star.site_id = "" }
    it { should_not be_valid }
  end

  describe "when item_id is not present" do
    before { @star.item_id = "" }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { @star.url = "" }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @star.user_id = "" }
    it { should_not be_valid }
  end

  describe "when the star is already taken" do
    before do
      dup_star = @star.dup
      dup_star.save
    end

    it { should_not be_valid }
  end
end
