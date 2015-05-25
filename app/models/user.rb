class User < ActiveRecord::Base
  has_many :rentals

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: {super_admin: 'super_admin', admin: 'admin', member: 'member'}

end
