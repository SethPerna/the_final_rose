class ContestantsController < ApplicationController
  def show
    @contestant = Contestant.find(params[:id])
    @bachelorette = @contestant.bachelorette
  end
end
