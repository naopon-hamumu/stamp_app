class StampsController < ApplicationController
  def index
    @grouped_stamps = current_user.get_stamps
                           .order('participants.created_at DESC')
                           .group_by(&:stamp_rally_id)
  end
end
