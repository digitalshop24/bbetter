class SubscriptionType < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  validates :name, :key, presence: true
  validates_uniqueness_of :name, :key

  scope :active, -> { where active: true }
  scope :one_time, -> { active.where periodicity: 0 }
  scope :periodic, -> { where.not periodicity: 0 }
end
