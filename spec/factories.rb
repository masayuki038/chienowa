FactoryGirl.define do
  factory :user do

    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com" }

    initialize_with {User.find_or_create_by_email(email)}

    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :example, :class => User do
    sequence(:email) {|n| "user_#{n}@example.com"}
    initialize_with {User.find_or_create_by_email(email)}

    name "Example User"
    password "foobar"
    password_confirmation "foobar"
  end

end
