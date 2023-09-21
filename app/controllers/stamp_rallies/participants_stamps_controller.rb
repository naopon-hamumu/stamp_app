class StampRallies::ParticipantsStampsController < ApplicationController
  def create
    stamp = Stamp.find(params[:stamp_id])

    if current_user.get?(stamp)
      render json: { status: 'error', message: 'このスタンプは既に取得しています。' }
    elsif !current_user.get?(stamp) 
      current_user.get_stamp(stamp)
      render json: { status: 'success', message: 'スタンプをゲットしました！' }
    else
      render json: { status: 'error', message: 'スタンプの保存に失敗しました。' }
    end
  end
end
