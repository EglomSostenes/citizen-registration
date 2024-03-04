# frozen_string_literal: true

FactoryBot.define do
  factory :citizen do
    full_name { Faker::Name.name_with_middle }
    cpf { Faker::IDNumber.unique.brazilian_citizen_number }
    cns { '185811852300009' }
    email { Faker::Internet.unique.email(domain: 'gmail.com') }
    phone { Faker::PhoneNumber.unique.cell_phone }
    birthday { Faker::Date.between(from: 110.years.ago, to: 2.years.ago) }
    status { rand(0..1) }
  end
end
