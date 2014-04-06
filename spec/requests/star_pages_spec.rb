require 'spec_helper'

describe "StarPages" do

  subject { page }

  describe "index" do
    before do
      user = FactoryGirl.create(:user)
      author1 = FactoryGirl.create(:user, name: "masayuki038")
      author2 = FactoryGirl.create(:user, name: "test")
      sign_in user
      FactoryGirl.create(:star1, user: user)
      FactoryGirl.create(:star2, user: user)
      visit star_items_path
    end

    it { should have_title('Starred') }
    it { should have_content('Starred') }
    it { should have_selector(:xpath, ".//img[@alt='masayuki038']") }
    it { should have_selector(:xpath, ".//img[@alt='test']") }
    it { should have_link('title1', href: "https://chienowa.heroku.com/masayuki038/items/15") }
    it { should have_link('title2', href: "https://chienowa.heroku.com/test/items/44") }
  end
end
