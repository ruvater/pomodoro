class Subcategory
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :periods
  belongs_to :category

  validates :name, presence: true

  field :name, type: String
  field :background, type: String, default: "black"
  field :white_text, type: Boolean, default: true

end
