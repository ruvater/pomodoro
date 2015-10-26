class PagesController < ApplicationController

  layout false

  def start_work
  end

  def categories
    @categories = Category.all
  end

  def statistics
  end
end
