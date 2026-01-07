class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy

  validates :name,
            presence: { message: "Please enter your name" }

  validates :email,
            presence: { message: "Please enter your e-mail address" },
            uniqueness: { case_sensitive: false, message: "Your email address is already in use" }

  validates :password,
            length: { minimum: 6, message: "Please enter the password with at least 6 characters" },
            allow_nil: true

  validate :cannot_remove_last_admin, on: :update, if: :admin_changed?
  before_destroy :cannot_destroy_last_admin

  before_validation :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def cannot_remove_last_admin
    if admin_was && !admin && User.where(admin: true).where.not(id: id).empty?
      errors.add(:base, "Cannot change privileges because there are zero administrators")
      throw(:abort)
    end
  end

  def cannot_destroy_last_admin
    if admin? && User.where(admin: true).where.not(id: id).empty?
      errors.add(:base, "Cannot delete because there are zero administrators")
      throw(:abort)
    end
  end
end