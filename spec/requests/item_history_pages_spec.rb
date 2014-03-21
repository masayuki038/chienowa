require 'spec_helper'

describe "ItemHistory pages" do
  subject { page }

  describe "GET /item_history_pages" do
    before { visit item_histories_path }
    it { should have_content("Histories") }
    it { should have_title("Histories") }
  end

end
