class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def top; end

  def sitepolicy; end

  def privacypolicy; end
end
