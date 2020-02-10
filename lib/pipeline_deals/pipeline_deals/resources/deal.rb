module PipelineDeals
  
  class Deal < Client

    def initialize options = {}
      @endpoint = 'api/v3/deals.json'
      super options
    end

    def index params = {}
      allowed_params = [:page, :per_page, :api_key]
      super params.transform_keys(&:to_sym).slice(*allowed_params)
    end

    def index_all params = {}
      allowed_params = [:per_page, :api_key]
      super params.transform_keys(&:to_sym).slice(*allowed_params)
    end

  end

end