class StampRallies::ParticipantsStampsController < ApplicationController
  def create
    participating = current_user.participants.find_by(stamp_rally_id: params[:stamp_rally_id])

    if ParticipantsStamp.exists?(stamp_id: params[:stamp_id], participant_id: participating.id)
      render json: { status: 'error', message: 'このスタンプは既に取得しています。' }
      return
    end

    if ParticipantsStamp.create(stamp_id: params[:stamp_id], participant_id: participating.id)
      render json: { status: 'success', message: 'スタンプをゲットしました！' }
    else
      render json: { status: 'error', message: 'スタンプの保存に失敗しました。' }
    end
  end
end
