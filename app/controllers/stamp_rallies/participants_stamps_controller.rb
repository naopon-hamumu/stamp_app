class StampRallies::ParticipantsStampsController < ApplicationController
  def index
    @stamps = ParticipantsStamp.where(participant_id: current_user.id)
  end

  def create
    
  end
end
