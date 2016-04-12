class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :timeoutable

  def display_name
    name.blank? ? email : name
  end
end
