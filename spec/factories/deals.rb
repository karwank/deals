# == Schema Information
#
# Table name: deals
#
#  id            :bigint           not null, primary key
#  external_id   :integer
#  name          :string
#  deal_stage_id :integer
#  value         :decimal(10, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :deal do

    external_id { Faker::Number.within(range: 0..999999) }
    name { Faker::Company.name }
    deal_stage { FactoryBot.create(:deal_stage) }
    value { Faker::Number.decimal(l_digits: 3, r_digits: 2) }

  end
end
