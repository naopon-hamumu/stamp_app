class StampRallies::ParticipantsController < ApplicationController
  def create
    @stamp_rally = StampRally.find(params[:stamp_rally_id])
    participant = current_user.participate(@stamp_rally)
    redirect_back fallback_location: root_path
  end

  def destroy
    @stamp_rally = StampRally.find(params[:stamp_rally_id])
    current_user.cancel_participate(@stamp_rally)
    redirect_back fallback_location: root_path
  end
end
