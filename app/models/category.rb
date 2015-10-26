class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :cycles

  validates :name, presence: true

  field :name, type: String
  field :background, type: String, default: "black"
  field :white_text, type: Boolean, default: true

end
