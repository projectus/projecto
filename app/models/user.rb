class User < ActiveRecord::Base
	
  validates :username, presence: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations

  has_many :comments
end
