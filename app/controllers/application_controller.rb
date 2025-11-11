class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    # Use locale param if available, otherwise use the default
    I18n.locale = params[:locale].presence_in(I18n.available_locales) || I18n.default_locale
  end

  def default_url_options
    # Always include the current locale in generated URLs
    { locale: I18n.locale }
  end
end
