require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Blogger072023
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    config.action_dispatch.cookies_same_site_protection = :strict

  end
end
