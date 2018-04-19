class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validate :seller_or_buyer
    
  def seller_or_buyer
      if buyer_flag == seller_flag
          errors.add(:buyer_flag, "どちらか選択してください。")
      end
  end
  
  after_save :set_role
  def set_role
    if self.buyer_flag?
      self.add_role :buyer
    elsif self.seller_flag?
      self.add_role :seller
    end
  end
         
  mount_uploader :image, ImageUploader
  
  has_many :requests
end
