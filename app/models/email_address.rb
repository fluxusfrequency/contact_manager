class EmailAddress < ActiveRecord::Base
  attr_accessible :address, :contact_id, :contact_type

  belongs_to :contact, polymorphic: true

  validates :address, :contact_id, presence: true
end
