class StampRalliesController < ApplicationController
  before_action :set_stamp_rally, only: %i[edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @q = StampRally.ransack(params[:q])
    @stamp_rallies = @q.result(distinct: true).includes(:stamps, :user).order(updated_at: :desc)
    @all_stamp_rallies = @stamp_rallies.public_open.order(updated_at: :desc).page(params[:page])

    return unless user_signed_in?

    @own_stamp_rallies = current_user.stamp_rallies.includes(:stamps).order(updated_at: :desc).page(params[:own_page])

    return unless current_user.participants.present?

    @participate_stamp_rallies = current_user.participate_stamp_rallies.order(created_at: :desc).page(params[:participate_page])
  end

  def new
    @stamp_rally = StampRally.new
    @stamps = @stamp_rally.stamps.build
  end

  def create
    @stamp_rally = current_user.stamp_rallies.build(stamp_rally_params)
    if @stamp_rally.save
      redirect_to @stamp_rally, success: t('defaults.message.created', item: StampRally.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: StampRally.model_name.human)
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @stamp_rally = StampRally.includes(:stamps).find(params[:id])
    @stamps = @stamp_rally.stamps
  end

  def edit; end

  def update
    if @stamp_rally.update(stamp_rally_params)
      redirect_to @stamp_rally, success: t('defaults.message.updated', item: StampRally.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: StampRally.model_name.human)
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @stamp_rally.destroy!
    redirect_to stamp_rallies_path, success: t('defaults.message.deleted', item: StampRally.model_name.human)
  end

  private

  def set_stamp_rally
    @stamp_rally = current_user.stamp_rallies.find(params[:id])
  end

  def stamp_rally_params
    params.require(:stamp_rally).permit(:title, :description, :image, :image_cache, :visibility,
                                        stamps_attributes: %i[id name sticker latitude longitude address _destroy])
  end
end
