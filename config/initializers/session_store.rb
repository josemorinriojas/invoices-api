# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store, key: "_#{Rails.application.class.module_parent_name.underscore}_session"
