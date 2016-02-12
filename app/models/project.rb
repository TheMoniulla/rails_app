class Project < ActiveRecord::Base
  validates :name, :user_id, presence: true

  belongs_to :user

  def to_s
    name
  end
end