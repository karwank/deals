require 'rails_helper'

RSpec.describe DealStagesController, type: :controller do

  describe "GET #index" do

    let!(:deal_stage) { FactoryBot.create(:deal_stage, percent: 99) }
    let!(:deal_stage2) { FactoryBot.create(:deal_stage, percent: 1) }

    before do
      get :index
    end

    it 'routes GET / to DealsStagesController#index' do
      should route(:get, '/').to(action: :index)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders index template" do
      should render_template('index')
    end

    it "assigns list of deal_stages" do
      expect(assigns(:deal_stages)).to_not be_nil
      expect(assigns(:deal_stages)).to_not be_empty
    end

    it "assigns list of deal_stages in the right order" do
      expect(assigns(:deal_stages)).to eq([deal_stage2, deal_stage])
    end

  end

end
