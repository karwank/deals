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

class Deal < ApplicationRecord
  
  # validations
  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true

  # associations
  belongs_to :deal_stage
  
end
