# Zget

A simple, zeroconf-based, p2p file transfer utility. A port of [zget](https://github.com/nils-werner/zget).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "zget"
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install zget
```

## Usage

### Sharing

```
$ zput awesome_file.zip
```

Then the other end can just:

```
$ zget awesome_file.zip
```

### Receiving

```
$ zget awesome_file.zip
```

Then the other end can just:

```
$ zput awesome_file.zip
```

### Aliases

In case of complicated filenames you can use aliases or have `zget`/`zput`
generate one for you:

```
$ zput myReaLlyComp_licat3d_fiLeNam3.zip
Download this file using `zget myReaLlyComp_licat3d_fiLeNam3.zip` or `zget e208`
```

Also `zget` can generate an alias so you can initiate the transfer without
knowing what file will be transferred:

```
$ zget
Upload a file using `zput <filename> 8332`
```

### Options

To see the available options you can just run:

```
$ zget -h
```

or

```
$ zput -h
```

## Compatibility

Unfortunately this version isn't compatible with python's zget. The main reason
is because [dnssd](github.com/tenderlove/dnssd) doesn't play well with service
names with a dot, therefore we can't use the same service name as python's zget.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO

* Improve the test suite

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/patriciomacadden/zget](https://github.com/patriciomacadden/zget).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

