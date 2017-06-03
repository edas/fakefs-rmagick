# FakeFS/Rmagick

Allows to use [RMagick](https://rmagick.github.io/) with [FakeFS](https://github.com/fakefs/fakefs)


Warning:  Both FakeFS and FakeFS break usual naming convention for gems ('fakefs' => `FakeFS`, 'rmagick' => `Magick`). I choosed to respect the naming of these gem so I had to break these conventions myself. The gem name is "fakefs-rmagick" but the corresponding module will be in `FakeFS::Magick`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fakefs-rmagick'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fakefs-rmagick

## Usage

To be able to use RMagick with FakeFS:

```ruby
require 'fakefs'
require 'fakefs/rmagick'
```

This will slow Magick::Image#write and a little but may also consume a lot of memory when writing large images. If you want, you may activate the override on demand with the following:

```ruby
require 'fakefs/safe'
require 'fakefs/rmagick/safe'

FakeFS::Magick.activate!
FakeFS.activate!
  # your code
FakeFS.deactivate!
FakeFS::Magick.activate!

# or (preferably)

FakeFS::Magick.with do
  FakeFS.with do
    # your code
  end
end
```

(the order doesn't matter, you can also start with FakeFS and then activate FakeFS::Magik)

For convenience, you can hook directly into FakeFS and let FakeFS::Magick activate itself automaticaly with FakeFS.

```ruby
require 'fakefs/rmagick/hook'
```

or manualy with:
```ruby
require 'fakefs/rmagick/safe'

FakeFS::Magick.hook!
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/edas/fakefs_rmagick.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

