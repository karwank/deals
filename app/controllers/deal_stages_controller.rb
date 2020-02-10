class DealStagesController < ApplicationController

  def index
    @deal_stages = DealStage.includes(:deals)
  end

end
