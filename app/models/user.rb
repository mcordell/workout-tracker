class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  has_many :programs

  def name
    "#{first_name} #{last_name}"
  end

  def current_program
    programs.active.first
  end
end
