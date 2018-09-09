# Mwcrawler

Mwcrawler is a gem for parsing UnB's Matricula Web data into consumable hashes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mwcrawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mwcrawler

## Usage

First instantiate a new crawler `crawler = Mwcrawler::Crawler.new` then you can crawl like so:
```ruby
courses_hash = crawler.courses
# return example
[{"type"=>"Presencial",
  "code"=>"19",
  "name"=>"ADMINISTRAÇÃO",
  "shift"=>"Diurno",
  "curriculums"=>
   [{"name"=>"Administração",
     "degree"=>"Bacharel",
     "semester_max"=>"8",
     "semester_min"=>"16",
     "credits"=>"200"}]},
 {"type"=>"Presencial",
  "code"=>"701",
  "name"=>"ADMINISTRAÇÃO",
  "shift"=>"Noturno",
  "curriculums"=>
   [{"name"=>"Administração",
     "degree"=>"Bacharel",
     "semester_max"=>"8",
     "semester_min"=>"16",
     "credits"=>"200"}]}
]
```
The crawled campus by default is `:darcy_ribeiro` campus,
but you can specify another `crawler.classes(:planaltina)`.

The available resources are `classes`, `courses` and `departments`. Also you can choose from any of the four campuses `:darcy_ribeiro`, `:planaltina`, `:ceilandia` and `:gama`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mwcrawler.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
