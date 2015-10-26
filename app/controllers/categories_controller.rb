class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    respond_to do |format|
      format.json { render inline: Category.all.order(:created_at).to_json }
    end
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.json { render @category.to_json, status: :created }
      else
        format.json { render inline: @category.errors.messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.json { render inline: @category.to_json }
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.json { render inline: @category.to_json }
      else
        format.json { render inline: @category.errors.messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.json { render nothing: true }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
