# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.prefix = '/trading-ui-assets'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( market.css market.js html5.js )

Dir[Rails.root.join('app/assets/javascripts/locales/*.js.erb')].each do |f|
  Rails.application.config.assets.precompile << File.join('locales', File.basename(f, '.erb'))
end
