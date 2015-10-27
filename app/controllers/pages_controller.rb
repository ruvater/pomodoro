class PagesController < ApplicationController

  layout false

  before_filter :settings

  def start_work
    @cycles = Cycle.all.order_by(finished_at: 'desc').limit(10)
  end

  def categories
    @categories = Category.all
  end

  def statistics
  end

  private

  def settings
    @settings = Setting.all
  end
end
