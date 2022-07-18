## [Unreleased]

- Pass message to raised exception

## [0.14.0] - 2022-07-15

- Fix parameter coercion if a parameter is validated multiple times
- Refactor `param` and `rule` functions into helpers
- Allow `param` and `rule` to be run independently

## [0.13.0] - 2022-07-15

- Capture `InvalidParameterError`s raised when running the parser 

## [0.12.0] - 2022-07-15

- Switch from a delegator to extending the context

## [0.11.0] - 2022-07-15

- Fix setting param values to false

## [0.10.0] - 2022-07-12

- Remove the `block` option from validators

## [0.9.0] - 2022-07-09

- Change parser to parse the definition outside of the initialize block

## [0.8.0] - 2022-07-09

- Add form helpers for form validator

## [0.7.0] - 2022-06-09

- Add `default` option for parameters
- Allow `default` option to be a proc or a lambda

## [0.6.0] - 2022-06-09

- Add `block` to run blocks of code in the route context

## [0.5.0] - 2022-06-09

- Allow the validator to be passed to the block for a valid parameter

## [0.4.0] - 2022-06-09

- Allow custom error messages to be used when validation fails
- Ensure running multiple validations for a single parameter merges the errors correctly
- Allow validations to run code if successful
- Allow exceptions to be raised by the parameter block to indicate failure
- Allow parameters to be passed to validators

## [0.3.0] - 2022-06-08

- Don't create entries in `params` for parameters that are not passed
- Don't set validator type during definition
- Add unique validator conditionals for each validator:
  - validate
  - validate_form
  - validate_url_param

## [0.2.0] - 2022-06-08

- Add validators:
  - Standard
  - URL Parameter
  - Form
- Add parameters:
  - Array
  - Boolean
  - Date
  - Float
  - Hash
  - Integer
  - String
  - Time
- Add rules:
  - All or none of
  - Any of
  - One of

## [0.1.0] - 2022-05-16

- Initial release
