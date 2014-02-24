FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "masayuki#{n}@example.com"}
    initialize_with {User.find_or_create_by_email(email)}

    name "Masayuki Takahashi"
    password "foobar"
    password_confirmation "foobar"
  end
end
