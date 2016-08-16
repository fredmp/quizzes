FactoryGirl.define do
  factory :answer, class: Quizzes::Answer do
    text "Answer"
    correct false
  end
end
