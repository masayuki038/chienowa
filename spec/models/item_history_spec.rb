require 'spec_helper'

describe ItemHistory do
  before { @item_history = ItemHistory.new(item_id: 1, revision: 1, title: "hoge", content: "foobar", title_diff: "hogehoge", content_diff: "barfoo") }

  subject { @item_history }

  it { should respond_to(:item_id) }
  it { should respond_to(:revision) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:title_diff) }
  it { should respond_to(:content_diff) }

  describe "when item_id is not present" do
    before { @item_history.item_id = nil }
    it { should_not be_valid }
  end

  describe "when revision is not present" do
    before { @item_history.revision = nil }
    it { should_not be_valid }
  end

  describe "when title is not present" do
    before { @item_history.title = " " }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { @item_history.content = " " }
    it { should_not be_valid }
  end

  describe "when (item_id, revision) are already assigned" do
    before do
      copied = @item_history.dup
      copied.save
    end

    it { should_not be_valid }
  end
end
