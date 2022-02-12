if Rails.env == 'production'
  Rails.application.config.session_store :cookie_store, key: '_nye_menu_session', domain: 'devapi.nyemenu.com'
else
  Rails.application.config.session_store :cookie_store, key: '_nye_menu_session'
end
