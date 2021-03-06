require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob")
      FactoryGirl.create(:user, name: "Ben")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }

      it { should have_selector('div.pagination') }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:item, user: user, title: "Foo", content: "hoge") }
    let!(:m2) { FactoryGirl.create(:item, user: user, title: "Bar", content: "foge") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "items" do
      it { should have_link(m1.title) }
      it { should have_link(m2.title) }
      it { should have_content(user.items.count) }
    end
  end

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account" }
    it { should have_content('Sign up') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.build(:user) }
      before do
        fill_in "Name", with: user.name
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password_confirmation
      end

      describe "after saving the user" do
        before { click_button submit }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }

      describe "with invalid information" do
        before { click_button "Save changes" }

        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      let(:new_name) { FactoryGirl.build(:user).name }
      let(:new_email) { FactoryGirl.build(:user).email }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
   end
  end
end
