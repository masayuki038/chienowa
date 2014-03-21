require 'spec_helper'

describe ItemHistory do
  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item, user: user) }
  before do 
    @item_history = ItemHistory.new(
                                    item: item,
                                    revision: 1,
                                    title: "hoge",
                                    content: "foobar",
                                    title_diff: "hogehoge",
                                    content_diff: "barfoo"
                                    )
  end

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

  describe "should create a histry when item created" do
    specify { expect(item.reload.histories.size).to eq 1 }
  end

  describe "should create a history when content updated" do
    before do
      item.content = "test2"
      item.save!
    end

    it "should create a history when content updated" do
      item.histories.size.should == 2
      recent_history = item.reload.histories[0]
      recent_history.revision.should == 2
      recent_history.title_diff.should == nil
      recent_history.content_diff.include?("-Lorem ipsum").should be_true
      recent_history.content_diff.include?("+test2").should be_true
    end
  end

  describe "should create a history when title updated" do
    before do
      item.title = "title2"
      item.save!
    end

    it "should create a history when title updated" do
      item.histories.size.should == 2
      recent_history = item.reload.histories[0]
      recent_history.revision.should == 2
      recent_history.title_diff.should == "title2"
      recent_history.content_diff.should == nil
    end
  end

  describe "should create a history when title and content updated" do
    before do
      item.title = "title2"
      item.content = "test3"
      item.save!
    end

    it "should create a history when title and content updated" do
      item.histories.size.should == 2
      recent_history = item.reload.histories[0]
      recent_history.revision.should == 2
      recent_history.title_diff.should == "title2"
      recent_history.content_diff.include?("-Lorem ipsum").should be_true
      recent_history.content_diff.include?("+test3").should be_true
    end
  end

  describe "should not create a history with no change" do
    before do
      item.save!
    end

    specify { expect(item.reload.histories.size).to eq 1 }
  end
end
