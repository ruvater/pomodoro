class Setting
  include Mongoid::Document
  include Mongoid::Timestamps

  COLORS = %w(white black red green blue #3D1255)
  CYCLE_MINUTES = 25
  SHORT_BREAK_MINUTES = 5
  LONG_BREAK_MINUTES = 15
  CYCLES_TO_LONG_BREAK = 4

  validates :key, presence: true

  field :key, type: String
  field :value, type: String

end

