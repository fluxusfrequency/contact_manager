class Person < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id

  validates :first_name, :last_name, presence: true

  belongs_to :user

  include Contact

  def to_s
    "#{last_name}, #{first_name}"
  end
end
