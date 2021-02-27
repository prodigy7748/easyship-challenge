class Company < ApplicationRecord
  has_many :shipments

  before_create :generate_uuid

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
