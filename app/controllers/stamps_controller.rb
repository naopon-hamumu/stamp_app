class StampsController < ApplicationController
  def index
    @stamps = current_user.get_stamps.order('participants.created_at DESC')
                          .page(params[:page])
    @grouped_stamps = @stamps.to_a.group_by(&:stamp_rally_id)
  end
end
