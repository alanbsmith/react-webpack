require 'rails/generators'

module React
  module Webpack
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        desc "Installs necessary framework for react-webpack integration"

        def create_base_directories
          empty_directory("clients/components")
          empty_directory("app/assets/webpack")
        end

        def create_base_files
          puts "Creating base files"
          copy_file "webpack.config.js", "webpack.config.js"
          copy_file "babelrc", ".babelrc"
          copy_file "react_helper.rb", "app/helpers/react_helper.rb"
          copy_file "index.js", "client/index.js"
          copy_file "Procfile", "Procfile"
        end

        def install_foreman
          puts "Adding foreman gem"
          gem "foreman"
          if yes?("Run bundle install?")
            system("bundle install")
          else
            puts "Cool. Just remember to run 'bundle install' later."
          end
          puts "DONE"
        end

        def install_node_modules
          if npm_and_node_installed?
            initialize_npm_and_node_modules
          else
            puts "You'll need to install node & npm to be able to use React."
            puts "Visit https://nodejs.org/en/ to install."
          end
        end

        def inject_assets_into_pipeline
          puts "Injecting assets into pipeline"
          append_to_file "app/views/layouts/application.html.erb", "<%= javascript_include_tag 'bundle' %>"
          append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( bundle.js )"
        end

        private

        def npm_and_node_installed?
          system("which npm") && system("which node")
        end

        def initialize_npm_and_node_modules
          puts "Initalizing package.json"
          system("npm init -y")
          if yes?("Install node modules?")
            puts "Installing..."
            system("npm install --save babel-core babel-loader babel-preset-es2015 babel-preset-react classnames react react-dom webpack")
            append_npm_run_tasks
          else
            inject_into_file "package.json", node_dependencies, { after: '#readme"' }
            puts "Cool. We'll add a standard `package.json` with the appropriate dependencies for you now. Just remember to run 'npm install' later."
          end
        end

        def append_npm_run_tasks
          inject_into_file "package.json", '"watch": "webpack --watch --colors --progress"', { after: '"test": "echo \"Error: no test specified\" && exit 1",'}
        end

        def node_dependencies
          ',
  "dependencies": {
    "babel-core": "^6.7.7",
    "babel-loader": "^6.2.4",
    "babel-preset-es2015": "^6.6.0",
    "babel-preset-react": "^6.5.0",
    "classnames": "^2.2.5",
    "react": "^15.0.1",
    "react-dom": "^15.0.1",
    "webpack": "^1.13.0"
  }'
        end
      end
    end
  end
end
