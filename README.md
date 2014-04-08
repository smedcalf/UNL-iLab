[![Build Status](https://travis-ci.org/Rumel/UNL-iLab.png?branch=master)](https://travis-ci.org/Rumel/UNL-iLab)

## Useful links
* [Rspec-Rails](https://github.com/rspec/rspec-rails)
* [Factory Girl](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md)
* [Capybara](https://github.com/jnicklas/capybara)
* [Zeus](https://github.com/burke/zeus)

# Testing
## Getting Started
Install zeus `gem install zeus`

Initiate zeus in the ilab directory `zeus start`

Open up a new terminal and you can run zeus commands

* Zeus console `zeus c`
* Zeus server `zeus s`
* Run tests `zeus rspec spec/`

## Running tests
Zeus can be replaced with `bundle exec` in all of these.
It will be much slower though.

* Run all tests `zeus rspec spec/`
* Run only a file `zeus rspec spec/models/instructor_spec.rb`
* Run a specific test `zeus rspec spec/models/instructor_spec.rb:45` where 45
is the line number of the describe or it statement
