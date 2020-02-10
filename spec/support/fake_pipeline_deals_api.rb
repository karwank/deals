require 'sinatra/base'

class FakePipelineDealsApi < Sinatra::Base
  
  get '/api/v3/deals.json' do
    json_response 200, 'deals.json'
  end

  get '/api/v3/admin/deal_stages.json' do
    json_response 200, 'deal_stages.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end

end