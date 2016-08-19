$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quizzes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quizzes"
  s.version     = Quizzes::VERSION
  s.authors     = ["Frederico"]
  s.email       = ["martinsporto@gmail.com"]
  s.homepage    = "https://bitbucket.org/fredmp/quizzes"
  s.summary     = "A simple quiz engine based on rails"
  s.description = "A quiz engine that you can extend and customize to build your own game"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "pry"
  s.add_development_dependency "shoulda-matchers", "~> 3.1"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "annotate"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
end
