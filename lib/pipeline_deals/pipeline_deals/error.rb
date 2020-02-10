module PipelineDeals
  
  class Error < StandardError
    attr_reader :object

    def initialize message, object = nil
      @object = object
      super(message)
    end

  end
  
end