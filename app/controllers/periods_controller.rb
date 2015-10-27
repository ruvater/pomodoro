class PeriodsController < ApplicationController

  def start
    @period = Period.new(start_period_params)
    @period.started_at = Time.now

    respond_to do |format|
      if @period.save
        format.json { render inline: @period.to_json, status: :created }
      else
        format.json { render inline: @period.errors.messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  def finish
    @period = Period.get_unfinished
    @period.finished_at = Time.now
    respond_to do |format|
      if @period.update(finish_period_params)
        format.json { render inline: @period.to_json }
      else
        format.json { render inline: @period.errors.messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_period
      @period = Period.find(params[:id])
    end

    def start_period_params
      params.require(:period).permit(:description,:type,:category_id)
    end

    def finish_period_params
      params.require(:period).permit(:results)
    end
end
