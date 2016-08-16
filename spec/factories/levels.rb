FactoryGirl.define do
  factory :level, class: Quizzes::Level do
    number_of_questions 15
    name "Hard"
    code 1
  end
end
