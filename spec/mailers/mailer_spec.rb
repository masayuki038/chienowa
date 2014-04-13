require "spec_helper"

describe Mailer do
  let(:user) { FactoryGirl.create(:user, email: "masayuki038@gmail.com") }
  let(:item) { FactoryGirl.create(:item, user: user) }
  let(:commentator) { FactoryGirl.create(:user, name: "commentator") }
  let(:item_comment) { FactoryGirl.create(:item_comment, item: item, user: commentator) }

  it "should send a comment mail" do
    puts "comment_mailer_spec"
    Mailer.comment_email(item_comment).deliver
  end

end
