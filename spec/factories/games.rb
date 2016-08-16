FactoryGirl.define do
  factory :game, class: Quizzes::Game do
    user
    level
  end
end
