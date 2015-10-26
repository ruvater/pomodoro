class SubcategoriesController < ApplicationController
  before_action :set_subcategory, only: [:show, :update, :destroy]

  def create
    @subcategory = Subcategory.new(subcategory_params)

    respond_to do |format|
      if @subcategory.save
        format.json { render @subcategory.to_json, status: :created }
      else
        format.json { render inline: @subcategory.errors.messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.json { render inline: @subcategory.to_json }
    end
  end

  def update
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        format.json { render inline: @subcategory.to_json }
      else
        format.json { render inline: @subcategory.errors.messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subcategory.destroy
    respond_to do |format|
      format.json { render nothing: true }
    end
  end

  private
    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end

    def subcategory_params
      params.require(:subcategory).permit(:name,:background,:white_text)
    end
end
