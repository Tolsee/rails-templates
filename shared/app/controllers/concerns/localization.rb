module Localization
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale

    protected

    def switch_locale(&action)
      locale = extract_locale_from_param || I18n.default_locale

      I18n.with_locale(locale, &action)
    end

    def extract_locale_from_param
      I18n.available_locales.include?(params[:locale]&.to_sym) ? params[:locale].to_sym : nil
    end
  end
end
