class StampsController < ApplicationController
  def index
    @grouped_stamps = Stamp.includes(:participants, :stamp_rally)
                           .joins(:participants)
                           .where(participants: { user_id: current_user.id })
                           .order('participants.created_at DESC')
                           .group_by(&:stamp_rally_id)
  end
end
