class StampsController < ApplicationController
  def index
    @grouped_stamps = Stamp.joins(:participants, :stamp_rally)
             .where(participants: { user_id: current_user.id }).group_by(&:stamp_rally_id)
  end
end
