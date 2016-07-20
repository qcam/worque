# Worque

Worque is a CLI which is helpful to manage your daily notes

## Installation

Do not add this line to any Gemfile

```ruby
gem 'worque'
```

Install it by

    $ gem install worque

## Usage

This will create today task list at the returning path

```
worque --today --path ~/notes
# ~/notes/checklist-2016-07-19.md

export WORQUE_PATH=~/notes
worque --today
# ~/notes/checklist-2016-07-19.md

worque --yesterday
# ~/notes/checklist-2016-07-18.md

# If it's Friday today, this will return Friday's note
worque --yesterday
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/huynhquancam/worque. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

