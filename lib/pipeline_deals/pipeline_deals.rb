require_relative 'pipeline_deals/configuration.rb'
require_relative 'pipeline_deals/error.rb'
require_relative 'pipeline_deals/client.rb'
require_relative 'pipeline_deals/resources.rb'

module PipelineDeals
  
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
  
end