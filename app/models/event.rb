class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User", foreign_key: "user_id"

  validates :title, presence: true
  validates :venue, presence: true
  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
