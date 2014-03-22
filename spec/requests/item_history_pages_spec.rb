require 'spec_helper'

describe "ItemHistory pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item, user: user) }

  describe "GET /item_history_pages" do
    before { visit item_histories_path(item) }
    it { should have_content("Changes") }
    it { should have_title("Changes") }
    it { should have_content(user.name) }
  end

  describe "should show the histories with 1 update" do
    let!(:content_before) { item.content }
    before do
      item.content = "test2"
      item.save
      visit item_histories_path(item)
    end

    it { should have_content("-" << content_before) }
    it { should have_content("+test2") }

    describe "should show the histories with 2 updates" do
      before do
        item.content = "test3"
        item.save
        visit item_histories_path(item)
      end

      it { should have_content("-" << content_before) }
      it { should have_content("+test2") }
      it { should have_content("-" << "test2") }
      it { should have_content("+test3") }
    end
  end
end
