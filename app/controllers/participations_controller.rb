class ParticipationsController < ApplicationController
  before_action :set_stamp_rally, %i[create destroy]

  def create
    if participant = current_user.build(@stamp_rally)
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    if current_user.destroy(@stamp_rally)
      redirect_back fallback_location: root_path
    end
  end

  private

  def set_stamp_rally
    @stamp_rally = StampRally.find(params[:stamp_rally_id])
  end
end
