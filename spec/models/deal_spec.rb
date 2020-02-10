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

require 'rails_helper'

RSpec.describe Deal, type: :model do

  subject(:deal) { create(:deal) }

  describe 'validations' do

    it "is valid with valid attributes" do
      should be_valid
    end

    it "is not valid without a name" do
      deal = build(:deal, name: nil)
      expect(deal).to_not be_valid
      expect(deal.errors[:name]).to include("can't be blank")
    end

    it 'is validating presence of name' do
      should validate_presence_of(:name)
    end

    it "is not valid without an external_id" do
      deal = build(:deal, external_id: nil)
      expect(deal).to_not be_valid
      expect(deal.errors[:external_id]).to include("can't be blank")
    end

    it 'is validating uniqueness of external_id' do
      should validate_presence_of(:external_id)
    end

    it "is not valid with already taken exeternal_id" do
      deal2 = build(:deal, external_id: deal.external_id)
      expect(deal2).to_not be_valid
      expect(deal2.errors[:external_id]).to include("has already been taken")
    end

    it 'is validating uniqueness of external_id' do
      should validate_uniqueness_of(:external_id)
    end

  end

  describe 'associations' do

    it 'should have deal_stage association' do
      should belong_to(:deal_stage).class_name('DealStage')
    end

  end

  describe 'class_methods' do

    let(:deals) { PipelineDeals::Deal.new.index_all }
    
    it 'should create deal from data by find_or_create_by_data' do
      deal_data = deals.first
      described_class.find_or_create_by_data(deal_data)
      expect(described_class.count).to eq 1
    end

    it 'should create belongs_to association deal_stage from data by find_or_create_by_data' do
      deal_data = deals.first
      described_class.find_or_create_by_data(deal_data)
      expect(DealStage.count).to eq 1
    end

    it 'should retrieve and save deals' do
      described_class.retrieve!
      expect(described_class.count).to eq deals.count
    end

  end

end
