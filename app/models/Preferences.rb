class Preferences < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
end