class ApplicationController < ActionController::Base
  layout 'application'

  before_action do
    locale = params[:lang].presence || http_accept_language.compatible_language_from(I18n.available_locales)
    I18n.locale = locale if locale && I18n.available_locales.include?(locale.to_sym)
  end
end
