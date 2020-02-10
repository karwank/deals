require 'rails_helper'

feature 'Asking for Deals from PipelineDeals API' do

  let(:pipelinedeals_client) { PipelineDeals::Deal.new }

  scenario 'client retrieves list of deals' do
    expect(pipelinedeals_client.index).to be_an_instance_of(Array)
  end

  scenario 'client receives a deal' do
    expect(pipelinedeals_client.index.first['name']).to eq('King-Cremin')
  end

  scenario "client can't call a request with empty api_key" do
    expect { pipelinedeals_client.index(api_key: nil) }.to raise_error(an_instance_of(PipelineDeals::Error))
  end

end