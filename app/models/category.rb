class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :subcategories

  validates :name, presence: true

  field :name, type: String

end
