class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def top; end

  def site_policy; end

  def privacy_policy; end
end
