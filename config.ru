require './application'

map Apptentive::DeveloperCenter.assets_prefix do
  run Apptentive::DeveloperCenter.assets
end

run Apptentive::DeveloperCenter
