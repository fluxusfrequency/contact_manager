class Company < ActiveRecord::Base
  attr_accessible :name, :user_id

  validates :name, presence: true

  belongs_to :user

  include Contact

  def to_s
    "#{name}"
  end
end
