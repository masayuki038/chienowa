require 'spec_helper'

describe "Items" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "Contact Page" do
    before { visit contact_path }
    it { should have_content('Contact') }
  end

  describe "Search Page" do
    let!(:item) { FactoryGirl.create(:item, user: user) }
    describe "With query" do
      before { visit search_path + "?query=test" }
      it { should have_content('Test') }
    end

    describe "With no query" do
      before { visit search_path }
      it { should have_content('Test') }
    end
  end

  describe "item creation" do
    before { visit new_item_path }

    it { should have_content('New item') }

    describe "with invalid information" do

      it "should not create a item" do
        expect { click_button "Save changes" }.not_to change(Item, :count)
      end

      describe "error_message" do
        before { click_button "Save changes" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Title', with: "Test"
        fill_in 'Content', with: "Lorem ipsum"
      end
      it "should create an item" do
        expect { click_button "Save changes" }.to change(Item, :count).by(1)
        should have_title("Test")
        should have_selector('div.alert.alert-success')
        should have_link('Sign out', href: signout_path)
      end
    end
  end

  describe "item page" do
    let!(:item) { FactoryGirl.create(:item, user: user) }
    before { visit item_path(item) }

    it { should have_title(item.title) }
    it { should have_content(item.title) }
    it { should have_link(:edit) }
    it { should have_link(:delete) }

    describe "edit page" do
      before { click_link(:edit) }

      it { should have_title("Edit item") }
      it { should have_field('Title', with: 'Test') }
      it { should have_button("Save changes")}

      describe "update item" do
        before do
          fill_in 'Title', with: 'Test2'
          fill_in 'Content', with: 'Modified'
        end

        it "should update an item" do
          expect { click_button "Save changes" }.to change(Item, :count).by(0)
          should have_title(item.title)
        end
      end
    end

    describe "delete" do
      it "should be able to delete item" do
        expect do
          click_link("delete")
        end.to change(Item, :count).by(-1)
      end
    end

    describe "Comment" do
      it { should have_content("Comments") }
      describe "add" do
        let(:commentator) { FactoryGirl.create(:user, name: "commentator") }
        before do
          sign_in commentator
          visit item_path(item)
          fill_in 'item_comment_content', with:'comment test'
        end

        it "should create a comment" do
          expect { click_button "Add comment" }.to change(ItemComment, :count).by(1)
          should have_content(commentator.name)
          should have_content('comment test')
        end

        describe "add again" do
          let(:commentator2) { FactoryGirl.create(:user, name: "commentator2") }
          before do
            sign_in commentator2
            visit item_path(item)
            fill_in 'item_comment_content', with:'yet another comment'
          end

          it "should create a comment again" do
            expect { click_button 'Add comment' }.to change(ItemComment, :count).by(1)
            should have_content(commentator2.name)
            should have_content('yet another comment')
          end
        end

      end
    end
  end
end
