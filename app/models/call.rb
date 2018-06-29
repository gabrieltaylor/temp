class Call < ApplicationRecord
  validates :from, :to, presence: true
end
