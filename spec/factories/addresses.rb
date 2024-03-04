# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    citizen

    zip_code { Faker::Address.zip_code }
    street { Faker::Address.street_address }
    complement { Faker::Address.secondary_address }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    uf { "BA" }
    ibge_code { Faker::Number.number(digits: 7) }
  end
end
