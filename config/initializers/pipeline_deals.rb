require Rails.root.join('lib/pipeline_deals/pipeline_deals.rb')

PipelineDeals.configure do |config|
  config.api_key = ENV['PIPELINE_DEALS_API_KEY']
  config.api_host = 'https://api.pipelinedeals.com'
end
