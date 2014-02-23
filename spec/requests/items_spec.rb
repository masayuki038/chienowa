require 'spec_helper'

describe "Items" do
  subject { page }
  describe "Home page" do
    before { visit home_path }
    it { should have_content('sample') }
  end

  describe "Contact Page" do
    before { visit contact_path }
    it { should have_content('Contact') }
  end
end
