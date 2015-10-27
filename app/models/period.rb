class Period
  include Mongoid::Document

  belongs_to :subcategory

  field :started_at, type: DateTime
  field :finished_at, type: DateTime
  field :minutes_duration, type: Integer

  def self.get_unfinished
    self.where(finished_at: nil).order(:started_at).first
  end
end
