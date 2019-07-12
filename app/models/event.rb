class Event < ApplicationRecord

  validates :title, presence: true
  validates :venue, presence: true
  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
