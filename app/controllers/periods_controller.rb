class PeriodsController < ApplicationController

  def start
    @period = TYPES[get_type].new(start_period_params)
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
    @period = TYPES[get_type].get_unfinished
    @period.finished_at = Time.now
    respond_to do |format|
      if @period.update(finish_period_params)
        format.json
      else
        format.json { render inline: @period.errors.messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  private
    TYPES = {cycle: Cycle, break: Break}

    def set_period
      @period = Period.find(params[:id])
    end

    def get_type
      params.has_key?('cycle') ? :cycle : :break
    end

    def start_period_params
      params.require(get_type).permit(:description,:type,:subcategory_id,:_type,:is_long)
    end

    def finish_period_params
      params.require(get_type).permit(:results)
    end
end
