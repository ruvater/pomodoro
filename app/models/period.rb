class Period
  include Mongoid::Document

  belongs_to :subcategory

  field :description, type: String
  field :results, type: String
  field :started_at, type: Date
  field :finished_at, type: Category
  field :type, type: String

  def self.get_unfinished
    self.where(finished_at: nil).order(:started_at).first
  end
end
