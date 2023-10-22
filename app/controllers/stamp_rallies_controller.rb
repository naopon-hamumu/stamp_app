class StampRalliesController < ApplicationController
  include TagCreation
  include Recommend
  before_action :set_stamp_rally, only: %i[edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @q = StampRally.ransack(params[:q])
    @stamp_rallies = @q.result(distinct: true).includes(:stamps, :user)
    @all_stamp_rallies = @stamp_rallies.public_open.order(updated_at: :desc)
                                       .page(params[:page])

    return unless user_signed_in?

    own_rallies = current_user.stamp_rallies.includes(:stamps)
                              .order(updated_at: :desc)
    @own_stamp_rallies = @q.result(distinct: true).merge(own_rallies)

    return unless current_user.participants.present?

    participate_rallies = current_user.participate_stamp_rallies
                                      .order(created_at: :desc)
    @participate_stamp_rallies = @q.result(distinct: true)
                                   .merge(participate_rallies)

    if @recommend_tag = Recommend.recommend_tag(current_user)
      @recommend_stamp_rallies = Recommend.recommend_stamp_rallies(
                                        current_user,
                                        @recommend_tag,
                                        params)
                                        .includes(:user, :tags, :stamps)
      end
  end

  def show
    @stamp_rally = StampRally.includes(:stamps).find(params[:id])
  end

  def new
    @stamp_rally = StampRally.new
    @stamps = @stamp_rally.stamps.build
  end

  def edit; end

  def create
    @stamp_rally = current_user.stamp_rallies.build(stamp_rally_params)
    if @stamp_rally.save
      process_tags(@stamp_rally)
      redirect_to @stamp_rally, success: t('defaults.message.created', item: StampRally.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: StampRally.model_name.human)
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @stamp_rally.update(stamp_rally_params)
      process_tags(@stamp_rally)
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
