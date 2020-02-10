# == Schema Information
#
# Table name: deal_stages
#
#  id          :bigint           not null, primary key
#  external_id :integer
#  name        :string
#  percent     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :deal_stage do

    external_id { Faker::Number.within(range: 0..999999) }
    name { Faker::Subscription.status }
    percent { Faker::Number.within(range: 0..100) }

  end
end
