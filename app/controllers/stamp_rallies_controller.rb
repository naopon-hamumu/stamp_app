class StampRalliesController < ApplicationController
  before_action :set_stamp_rally, only: %i[edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @q = StampRally.ransack(params[:q])
    @stamp_rallies = @q.result(distinct: true).includes(:stamps, :user).order(updated_at: :desc)

    @all_stamp_rallies = @stamp_rallies.public_open
    if user_signed_in?
      @own_stamp_rallies = current_user.stamp_rallies.includes(:stamps).order(updated_at: :desc)
      @participate_stamp_rallies = current_user.participants.map do |participant|
        participant.stamp_rally
      end
    end
  end

  def new
    @stamp_rally = StampRally.new
    @stamps = @stamp_rally.stamps.build
  end

  def create
    @stamp_rally = current_user.stamp_rallies.build(stamp_rally_params)
    if @stamp_rally.save
      redirect_to @stamp_rally
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @stamp_rally = StampRally.find(params[:id])
    @stamps = @stamp_rally.stamps
  end

  def edit; end

  def update
    if @stamp_rally.update(stamp_rally_params)
      redirect_to @stamp_rally
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @stamp_rally.destroy!
    redirect_to top_path
  end

  private

  def set_stamp_rally
    @stamp_rally = current_user.stamp_rallies.find(params[:id])
  end

  def stamp_rally_params
    params.require(:stamp_rally).permit(:title, :description, :image, :visibility,
      stamps_attributes: [:name, :sticker, :latitude, :longitude, :address])
  end
end
