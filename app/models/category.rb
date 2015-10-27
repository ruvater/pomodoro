class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :subcategories

  validates :name, presence: true

  field :name, type: String

end
