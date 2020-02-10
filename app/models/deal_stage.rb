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

class DealStage < ApplicationRecord

  # validations
  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates_inclusion_of :percent, in: 0..100

  # associations
  has_many :deals

end
