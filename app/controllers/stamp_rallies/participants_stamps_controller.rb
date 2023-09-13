class StampRallies::ParticipantsStampsController < ApplicationController
  def index
    @paticipate_stamp_rallies = current_user.participants
  end

  def create
    
  end
end
