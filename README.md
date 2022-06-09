# Sinatra::Param::Validator

Validate parameters in a Sinatra app.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sinatra-param-validator

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sinatra-param-validator

## Sample Usage

```ruby
validator :user_id do
  param :id, Integer, required: true
end

get '/user/:id', validate: :user_id do
  # ...
end

validator :new_user do
  param :name, String, required: true
  param :age, Integer, required: true, min: 0 
end

post '/new-user', validate: :new_user do
  # ...
end
```

## Parameter Types

The following parameter types are built-in,
and values will be coerced to an object of that type.

* `Array`
  * Accepts a comma-separated list of values, as well as an array
  * e.g. `a,b,c`
* `Boolean`
  * `false|f|no|n|0` or `true|t|yes|y|1`
* `Date`
  * All formats accepted by `Date.parse`
* `Float`
* `Hash`
  * Accepts a comma-separated list of colon-separated key-value pairs
  * e.g. `a:1,b:2,c:3`
* `Integer`
* `String`
* `Time`
  * All formats accepted by `Time.parse`

Types can be defined using class names or symbols:

```ruby
param :name, String
param :tick_box, :boolean 
```

## Parameter Validations

```ruby
param :number, Integer, required: true, in: 0..100
```

All parameters have the following validations available:

* `nillable`
  * If this is set, all other validations are skipped if the value is nil
* `required`
  * The parameter must be present and cannot be nil
* `in`
  * The value is in the given array / range
* `is`
  * Match a specific value

`Array`, `Hash` and `String` have the following validations:

* `min_length` / `max_length`

`Date`, `Time`, `Float` and `Integer` have the following validations:

* `min` / `max`

## Custom Messages

It is possible to return a custom error message when a validation fails:

```ruby
param :number, Integer, required: true, message: 'The number is required'
```

## Rules

Rules work on multiple parameters:

```ruby
rule :all_or_none_of, :a, :b
```

* `all_or_none_of`
* `any_of`
  * At least one of the given fields must be present
* `one_of`
  * Only one of the given fields can be present

## Validator Types

The default validator will raise `Sinatra::ParamValidator::ValidationFailedError` when validation fails.

There are two other provided validators, that handle failure differently:

* `url_param`
  * will `halt 403`
* `form`
  * if [sinatra-flash](https://github.com/SFEley/sinatra-flash) is available, it will flash the errors and `redirect back`
  * will provide a JSON object with errors to an XHR request
  * will `halt 400`

These validators can be invoked with a different conditional on the route:

```ruby
post '/new-user', validate_form: :new_user do
  # ...
end


get '/user/:id', validate_url_param: :user_id do
  # ...
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, 
which will create a git tag for the version, push git commits and the created tag, 
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rickselby/sinatra-param-validator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
