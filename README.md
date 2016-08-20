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
The engine has "questions" and "game questions". The last one has a seed number used to shuffle the order of the answers. It is used to represent questions within a specific game.

In order to create a new game with a set of game questions we can use a factory:
```ruby
user  = Quizzes::User.new(name: 'A great gamer') # You can also extend this class and use your own
level = Quizzes::Level.first                     # A level is optional to create a game

game  = Quizzes::GameFactory.new({ user: user, level: level, number_of_questions: 20 }).generate
```
Each new game will be composed this way:

1. Unique questions for a particular game
2. New questions for a user (considering all past games)
3. Questions of the informed level

If some of these definitions cannot be completely accomplished, it'll fulfill what is missing with any avaliable questions. Besides, if a user plays all available questions and face an old question again, at least we'll have a different order for the answers.

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
You can contribute to improve quizzes by testing it locally and then:

- Suggesting new features
- Reporting bugs
- Forking it and submitting pull requests

## Next possible steps

- Questions with multiple choices
- Rankings
- Admin area
- Multiplayer mode
- Chat in multiplayer games
- Integration with common social media networks
- An optional command to install a set of basic views
- A space where a user (no admin) can create new questions to contribute to the game (these questions could be moderated by an admin later)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
