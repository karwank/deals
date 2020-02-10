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

  class << self

    def retrieve!
      deals_data = PipelineDeals::Deal.new.index_all(per_page: 50)
      deals_data.each do |deal_data|
        find_or_create_by_data(deal_data)
      end
    end

    def find_or_create_by_data data = {}
      if data['id'].present?
        self.find_or_create_by(external_id: data['id']) do |deal|
          deal.name = data['name']
          deal.value = data['value'].to_f
          deal.deal_stage = DealStage.find_or_create_by_data(data['deal_stage'])
        end
      end
    end

  end
  
end
