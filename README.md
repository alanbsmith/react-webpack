# React::Webpack
A simple tool for getting up and running with React-Webpack in Rails.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'react-webpack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install react-webpack

## Usage
_not currently supporting HAML_

* run the install generator with `rails g react:webpack:install`
* fire up the app with `foreman start`
* visit `http://localhost:3000`
* Add your components to `client/components/` and be sure to list them in `client/index.js`
* Add an `erb` tag for your components and props: `<%= react_component :Dropdown, listItems: [1,2,3,4] %>`

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/alanbsmith/react-webpack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
