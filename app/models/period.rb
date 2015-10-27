class Period
  include Mongoid::Document

  belongs_to :subcategory

  field :started_at, type: DateTime
  field :finished_at, type: DateTime
  field :minutes_duration, type: Integer

  def self.get_unfinished
    self.where(finished_at: nil).order_by(started_at: 'asc').first
  end
end
