FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "user-#{n}" } #sequence
    email { "#{name}@gmail.com" }       #dependent attribute
    password "password"
    role "user"

    trait :with_albums do
      ignore do
        album_count 3 # tells FG this is NOT an attribute
      end
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list :album, evaluator.album_count, user: user
    end

  end

  factory :admin do
  role "admin"
  factory :admin_with_albums, traits: [:with_albums]
  end

end
