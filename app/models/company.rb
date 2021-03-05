class Company < ApplicationRecord
  has_many :shipments

  validates :name, presence: true, uniqueness: true

  before_create :generate_uuid

  def generate_uuid
    self.id = SecureRandom.uuid
  end
end
