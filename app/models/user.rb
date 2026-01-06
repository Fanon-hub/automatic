class User < ApplicationRecord
  has_secure_password
  
  has_many :tasks, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :admin, inclusion: { in: [true, false] }
  
  before_validation :downcase_email
  
  # Admin validation callbacks
  before_destroy :check_last_admin
  before_update :check_last_admin_update
  
  private
  
  def downcase_email
    self.email = email.downcase if email.present?
  end
  
  def check_last_admin
    if admin? && User.where(admin: true).count <= 1
      errors.add(:base, '管理者が0人になるため削除できません')
      throw :abort
    end
  end
  
  def check_last_admin_update
    if admin_changed? && admin_was && User.where(admin: true).count <= 1
      errors.add(:base, '管理者が0人になるため権限を変更できません')
      throw :abort
    end
  end
end