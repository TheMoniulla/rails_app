class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :projects

  def to_s
    "#{first_name} #{last_name}"
  end

  def projects_for_display
    projects.map(&:to_s).join(', ')
  end
end