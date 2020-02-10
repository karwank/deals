module PipelineDeals
  
  class Configuration
    
    attr_accessor :api_key, :api_host
    
    def initialize
      @api_host = 'https://api.pipelinedeals.com'
    end
    
  end
  
end