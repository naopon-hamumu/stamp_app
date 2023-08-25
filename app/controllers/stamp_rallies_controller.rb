class StampRalliesController < ApplicationController
  before_action :set_stamp_rally, only: %i[edit update destroy]
  def index
    @stamp_rallies = StampRally.all
  end

  def new
    @stamp_rally = StampRally.new
    @stamp_rally.stamps.build
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
    @stickers = @stamp_rally.stamps.order(created_at: :asc)
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
    redirect_to stamp_rallies_path
  end

  private

  def set_stamp_rally
    @stamp_rally = current_user.stamp_rallies.find(params[:id])
  end

  def stamp_rally_params
    params.require(:stamp_rally).permit(:title, :description, :image, :visibility,
      stamps_attributes: [:name, :sticker, :address, :latitude, :longitude])
  end
end
