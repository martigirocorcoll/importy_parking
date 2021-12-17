class Car < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :entry_time, presence: true
end
