require "react/webpack/version"

module React
  module Webpack
    def self.hello(name)
      puts "Hello, #{name}!"
    end

    def self.goodbye
      puts "Bye!!"
    end
  end
end
