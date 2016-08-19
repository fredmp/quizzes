# Quizzes
A simple quiz engine based on rails that you can extend and customize to build your own game.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'quizzes'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install quizzes
```

With your database configuration defined, copy quizzes migrations:
```bash
$ bin/rails quizzes:install:migrations
```

And run it:
```bash
$ bin/rails db:migrate SCOPE=quizzes
```

## Usage
How to use my plugin.

## Import
You can import a CSV with questions. This file needs the following:
- A row with headers
- A column "question"
- A column "correct_answer"
- An arbitrary number of columns whose header starts with "answer" followed by a number (answer1, answer2,...). These are the incorrect answers
- The number of incorrect answers can be defined by a configuration (Rails.configuration.total_answers_by_question). Default is 4
- Optionally, a column "level" with a number representing the code of an existing Level in database

To import this file you can use a rake task:
```bash
$ rake "quizzes:import[/home/user/dir/file.csv]"
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
