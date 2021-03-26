# PupFind

Hi! This CLI gem will allow you to search nearby animal rescues to find available puppies near you! 

Note: You will be required to provide your own API key. [Please apply for one here](https://rescuegroups.org/services/request-an-api-key/) before using PupFind.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pup-find'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pup-find

## Usage

Simply enter your zip code and PupFind will extensively search through [RescueGroups'](https://rescuegroups.org/) database of affiliated animal rescues in the United States.

From there, you will receive a list of currently available puppies within 500 (note: will be changed to custom search scope) miles of your location. Follow the on-screen prompts to view more information about a particular puppy or to filter search results by various criteria. 

Happy searching!

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pup-find. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/pup-find/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PupFind project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pup-find/blob/master/CODE_OF_CONDUCT.md).

## Credits

[ManyTools](https://manytools.org/hacker-tools/ascii-banner/), for use of their ASCII banner generator.
