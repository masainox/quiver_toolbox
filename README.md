# QuiverToolbox

QuiverToolbox is utility tools for Quiver (http://happenapps.com/#quiver).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quiver_toolbox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quiver_toolbox

## Usage

	$ quiver-notebook create NOTEBOOK_NAME
	=> f5064fa4-2840-460d-b650-8064f1819b30.qvnotebook
	
	$ quiver-note create NOTE_TITLE NOTE_BODY --tags=mytag -p=./f5064fa4-2840-460d-b650-8064f1819b30.qvnotebook
	=> 451cc903-cfad-4db0-b425-7a59042fe70e.qvnote/6865295b-a3bc-40a6-aa74-951f6deba1f7.qvnote
	
See also

	$ quiver-note help
	$ quiver-notebook help

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/masainox/quiver_toolbox.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

