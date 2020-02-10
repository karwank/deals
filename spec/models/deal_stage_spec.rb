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

require 'rails_helper'

RSpec.describe DealStage, type: :model do

  subject(:deal_stage) { create(:deal_stage) }

  describe 'validations' do

    it "is valid with valid attributes" do
      should be_valid
    end

    it 'is validating presence of name' do
      should validate_presence_of(:name)
    end
    
    it "is not valid without a name" do
      deal_stage = build(:deal_stage, name: nil)
      expect(deal_stage).to_not be_valid
      expect(deal_stage.errors[:name]).to include("can't be blank")
    end

    it 'is validating inclusion of percent' do
      should validate_inclusion_of(:percent).in_range(0..100)
    end

    it "is not valid without an external_id" do
      deal_stage = build(:deal_stage, external_id: nil)
      expect(deal_stage).to_not be_valid
      expect(deal_stage.errors[:external_id]).to include("can't be blank")
    end

    it 'is validating uniqueness of external_id' do
      should validate_presence_of(:external_id)
    end

    it "is not valid with already taken exeternal_id" do
      deal_stage2 = build(:deal_stage, external_id: deal_stage.external_id)
      expect(deal_stage2).to_not be_valid
      expect(deal_stage2.errors[:external_id]).to include("has already been taken")
    end

    it 'is validating uniqueness of external_id' do
      should validate_uniqueness_of(:external_id)
    end

  end

  describe 'associations' do

    it 'should have deals association' do
      should have_many(:deals).class_name('Deal')
    end

  end

  describe 'scopes' do

    it 'is ordered by percent ASC by default' do
      deal_stage1 = create(:deal_stage, percent: 99)
      deal_stage2 = create(:deal_stage, percent: 1)

      expect(DealStage.all).to eq [deal_stage2, deal_stage1]
    end

  end

  describe 'class_methods' do

    let(:deals) { PipelineDeals::Deal.new.index_all }
    
    it 'should create deal from data by find_or_create_by_data' do
      deal_data = deals.first
      described_class.find_or_create_by_data(deal_data['deal_stage'])
      expect(described_class.count).to eq 1
    end

  end

end
