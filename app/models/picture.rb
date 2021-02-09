class Picture < ApplicationRecord
  validates :image, presence: true
end
