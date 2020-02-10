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

  # scopes
  default_scope { order(percent: :asc) }

  def total_value
    deals.pluck(:value).sum
  end

  class << self

    def find_or_create_by_data data = {}
      if data["id"].present?
        self.find_or_create_by(external_id: data["id"]) do |deal_stage|
          deal_stage.name = data['name']
          deal_stage.percent = data['percent']
        end
      end
    end

  end

end
