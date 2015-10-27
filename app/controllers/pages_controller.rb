class PagesController < ApplicationController

  layout false

  before_filter :settings

  def start_work
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
