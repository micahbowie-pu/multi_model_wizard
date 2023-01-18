# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/numeric/time'

module MultiModelWizard
  module CookieStore
    extend ActiveSupport::Concern

    EXPIRATION = 1.hour

    def set_signed_cookie(attributes)
      cookies.signed[attributes[:key]&.to_sym] = {
        value: attributes[:value],
        expires: attributes[:expires] || EXPIRATION.from_now,
        same_site: attributes[:same_site] || 'None',
        secure: attributes[:secure] || true,
        httponly: attributes[:httponly] || true
      }
    end

    def get_signed_cookie(key)
      cookies.signed[key.to_sym]
    end

    def delete_cookie(key)
      cookies.delete(key.to_sym)
    end
  end
end
