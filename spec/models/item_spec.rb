require 'spec_helper'

describe Item do

  let(:user) { FactoryGirl.create(:user) }
  before { @item = user.items.build(title: "test", content: "Lorem ipsum") }

  subject { @item }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @item.user_id = nil }
    it { should_not be_valid }
  end

  describe "when blank content" do
    before { @item.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is so long" do
    before { @item.content = "a" * 1024 * 1024 }
    it { should be_valid }
  end
end
