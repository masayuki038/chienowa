FactoryGirl.define do
  factory :user do

    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com" }

    initialize_with {User.find_or_create_by(email: email)}

    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :example, :class => User do
    sequence(:email) {|n| "user_#{n}@example.com"}
    initialize_with {User.find_or_create_by(email: email)}

    name "Example User"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :item do
    title "Test"
    content "Lorem ipsum"
    user
  end

  factory :star do
    site_id "sample_test_id"
    item_id "sample_item_id"
    url "http://example.com/items/sample-item"
    title "sample test"
    author "test_author"
    user_id 10
  end

  factory :star1, :class => 'Star' do
    site_id "sample_test_id"
    item_id "15"
    url "https://chienowa.heroku.com/masayuki038/items/15"
    title "title1"
    author "masayuki038"
    user_id 10
  end

  factory :star2, :class => 'Star' do
    site_id "sample_test_id"
    item_id "44"
    url "https://chienowa.heroku.com/test/items/44"
    title "title2"
    author "test"
    user_id 10
  end
end
