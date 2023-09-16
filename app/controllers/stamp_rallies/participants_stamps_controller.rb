class StampRallies::ParticipantsStampsController < ApplicationController
  def create
    stamp = Stamp.find(params[:stamp_id])
    participant = current_user.participants.find_by(stamp_rally_id: params[:stamp_rally_id])
    
    if ParticipantsStamp.create(stamp: stamp, participant: participant)
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: '保存に失敗しました。' }
    end
  end
end
