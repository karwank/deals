module PipelineDeals
  
  class Client

    def initialize options = {}
      @config = PipelineDeals.configuration
      @config.api_key = options[:api_key] if options.has_key? :api_key
      @client = RestClient::Resource.new(@config.api_host)[@endpoint]
    end

    def index params = {}
      params.reverse_merge!(api_key: @config.api_key, page: 1)
      raise 'api_key is required' if params[:api_key].blank?
    
      response = @client.get params: params, content_type: :json
      if response.present?
        content = JSON.parse(response.body)
        content['entries']
      else
        raise 'response is not present'
      end

    rescue => error
      raise PipelineDeals::Error.new(self), error.to_s
    end


    def index_all params = {}
      
      params.reverse_merge!(api_key: @config.api_key, page: 1)
      raise 'api_key is required' if params[:api_key].blank?

      resources = []
      finished = false

      while !finished
        finished = true
        response = @client.get params: params, content_type: :json
        
        if response.present?
          content = JSON.parse(response.body)

          if content.has_key? 'entries'
            resources += content['entries']
          end

          if content.has_key? 'pagination'
            finished = content['pagination']['pages'] <= content['pagination']['page']
          end

          params[:page] += 1 unless finished
        else
          raise 'response is not present'
        end

      end

      resources

    rescue => error
      raise PipelineDeals::Error.new(error.message, self)
    end

  end

end
