class StampRallies::ParticipantsStampsController < ApplicationController
  def index
    @stamps = current_user.participants.stamps
  end

  def create
    
  end
end
