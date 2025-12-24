class Task < ApplicationRecord
  validates :title, presence: { message: I18n.t('errors.messages.blank_title') }
  validates :content, presence: { message: I18n.t('errors.messages.blank_content') }
end
