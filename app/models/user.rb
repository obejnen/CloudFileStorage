class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :own_folders, class_name: "Folder"
  has_many :folder_shares
  has_many :folders, through: :folder_shares

  has_many :own_items, class_name: "Item"
  has_many :item_shares
  has_many :items, through: :item_shares
end