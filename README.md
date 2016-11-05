# Metrobus ![Build Status](https://api.travis-ci.org/sbower/metrobus.svg) [![Gem Version](https://badge.fury.io/rb/metrobus.svg)](https://badge.fury.io/rb/metrobus) [![Coverage Status](https://coveralls.io/repos/github/sbower/metrobus/badge.svg?branch=master)](https://coveralls.io/github/sbower/metrobus?branch=master)

Library to wrap the metrotransit.org web services which provide real-time transit departure data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metrobus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metrobus

## Usage

### Metrobus::Route

If you want to get all available routes for the day you can use the following.

```ruby
all_routes = Metrobus::Route.all
```

If you want to get the routes that match a string you can do something like.

```ruby
found_routes = Metrobus::Route.find("u of m")
```

In this example all routes containing the string "u of m" will be returned,
output might look something like.

```*************************
2 - Franklin Av - Riverside Av - U of M - 8th St SE
3 - U of M - Como Av - Energy Park Dr - Maryland Av
6 - U of M - Hennepin - Xerxes - France - Southdale
16 - U of M - University Av - Midway
87 - Rosedale - U of M St Paul - Cleveland Av
111 - Ltd Stop - 66th St - Chicago - Cedar - U of M
113 - Ltd Stop - Grand Av S - Lyndale Av S - U of M
114 - Ltd Stop - Excelsior Blvd - Uptown - U of M
115 - Ltd Stop - Grand Av S - Uptown - U of M
118 - Ltd Stop - Central Av - Lowry Av - U of M
120 - U of M Stadium Super Shuttle
121 - U of M - Campus Connector
122 - U of M - University Ave Circulator
123 - U of M - 4th Street Circulator
124 - U of M - Saint Paul Circulator
129 - U of M - Huron Shuttle
252 - 95AV P&R- U of M
272 - Express - Maplewood - Roseville - U of M
465 - Burnsville-Minneapolis-U of M
475 - Apple Valley-Cedar Grove-Mpls/U of M
579 - Express - U of M - Southdale
652 - Express - Plymouth Rd - Co Rd 73 P&R - U of M
789 - Maple Grove - U of M
*************************
```

If you have a route object you can get the direction_id with the following:

```ruby
found_routes = Metrobus::Route.find("u of m")
route = found_routes[0]
direction_id = route.get_direction_id(direction)
```

### Metrobus::Direction

You can get the valid directions for a route with the following.  Note you have
to send the route number.

```ruby
directions = Metrobus::Direction.get('901')
```
The result is an array of directions which should be of length 2.  Routes run
east/west and north/south.  Directions are identified with an ID value. 1 = South,
2 = East, 3 = West, 4 = North.


### Metrobus::Stop

If you are looking for a stop on a specific route going a specific direction
you could use the following.  Directions are identified with an ID value.
1 = South, 2 = East, 3 = West, 4 = North.

```ruby
stops = Metrobus::Stop.get('121', '2')
```

If you want to get the stop that match a string you can do something like.

```ruby
found_stop = Metrobus::Stop.find("target")
```

In this example all routes containing the string "target" will be returned,
output might look something like.

>*************************
Target Field Station Platform 1
Target Field Station Platform 2
*************************

### Metrobus::Departure

If you are looking for upcoming departures you can supply the route id, diercetion and stop_id like so.

```ruby
departures = Metrobus::Departure.get('5', '4', '7SOL')
```
This will return an array of departures in ascending time order.  If you wanted to get the time of the next departure
you could do something likes this.

```ruby
departures = Metrobus::Departure.get('5', '4', '7SOL')
departures[0].get_next_departure_time
```
This will return a string with the number of minutes until the next departure.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sbower/metrobus. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
