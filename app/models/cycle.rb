class Cycle < Period
  belongs_to :subcategory
  field :description, type: String
  field :results, type: String

  def started_time
    minutes = (started_at.min / 5.0).round * 5
    return started_at.strftime('%d.%m.%y %H:') + (minutes/10).to_s + (minutes % 10).to_s
  end
end
 