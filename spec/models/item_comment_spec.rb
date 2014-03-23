require 'spec_helper'

describe ItemComment do
  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item, user: user) }

  before do
    @item_comment = ItemComment.new(
                                    item: item,
                                    user: user,
                                    content: "test"
                                   )
  end

  subject { @item_comment }

  it { should respond_to(:item_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:content) }

  describe "when item_id is not present" do
    before { @item_comment.item_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @item_comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { @item_comment.content = nil }
    it { should_not be_valid }
  end

  describe "parent Item should have a comment" do
    before{ @item_comment.save! }
    specify { expect(item.reload.comments.size).to eq 1 }
  end

  describe "parent User should have a comment" do
    before{ @item_comment.save! }
    specify { expect(user.reload.comments.size).to eq 1 }
  end

end
