class Setting
  include Mongoid::Document
  include Mongoid::Timestamps

  validates :key, presence: true

  field :key, type: String
  field :value, type: String

end

