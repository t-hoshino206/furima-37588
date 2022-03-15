FactoryBot.define do
  factory :user do
    japanese_user = Gimei.name

    nickname { japanese_user.kanji }
    email { Faker::Internet.email }
    password = '1a' + Faker::Internet.password(min_length: 4)
    password { password }
    password_confirmation { password }
    last_name { japanese_user.last.kanji }
    first_name { japanese_user.first.kanji }
    last_name_kana { japanese_user.last.katakana }
    first_name_kana { japanese_user.first.katakana }
    birth_date {Faker::Date.between(from: '1930-01-01', to: '2017-12-31')}
  end
end
