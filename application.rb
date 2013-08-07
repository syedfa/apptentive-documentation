require 'bundler'
Bundler.require

module Apptentive
  class DeveloperCenter < Sinatra::Base

    set :root,          File.dirname(__FILE__)
    set :assets,        Sprockets::Environment.new(root)
    set :precompile,    [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
    set :assets_prefix, '/assets'
    set :digest_assets, false
    set(:assets_path)   { File.join public_folder, assets_prefix }

    configure do
      %w{javascripts stylesheets images}.each do |type|
        assets.append_path "assets/#{type}"
        # assets.append_path Compass::Frameworks['bootstrap'].templates_directory + "/../vendor/assets/#{type}"
      end

      Sprockets::Helpers.configure do |config|
        config.environment = assets
      #   config.prefix      = assets_prefix
      #   config.digest      = digest_assets
      #   config.public_path = public_folder
      end
      Sprockets::Sass.add_sass_functions = true

      # set :haml, { :format => :html5 }
      # set :sass, Compass.sass_engine_options
    end

    helpers do
      include Sprockets::Helpers
    end

    get '/' do
      haml :index
    end

    get '/:path' do
      haml params[:path].to_sym
    end
  end

end

