class Api::RankingsController < ApplicationController
  def scoresheet
    scores = User.scoresheet
    respond_to do |format|
      format.json { render json: scores }
    end
  end
end

