require 'rails_helper'

module Quizzes
  RSpec.describe Question, type: :model do

    it { should validate_presence_of(:text) }
    it { should validate_uniqueness_of(:text) }

    it "limits the number of allowed answers" do
      question = FactoryGirl.create(:question)

      question.answers.create({ text: "Answer - 1", correct: true })
      question.answers.create({ text: "Answer - 2", correct: false })
      question.answers.create({ text: "Answer - 3", correct: false })
      question.answers.create({ text: "Answer - 4", correct: false })

      expect {
        question.answers.create({ text: "Answer - 5", correct: false })
      }.to raise_error("This question has reached the maximum number of allowed answers")
    end

    it "allows only one correct answer" do
      question = FactoryGirl.create(:question)

      question.answers.create({ text: "Answer - 1", correct: false })
      question.answers.create({ text: "Answer - 2", correct: false })
      question.answers.create({ text: "Answer - 3", correct: true })

      expect {
        question.answers.create({ text: "Answer - 4", correct: true })
      }.to raise_error("A question can have only one correct answer")
    end

    it "ensures at least one correct answer" do
      question = FactoryGirl.create(:question)

      question.answers.create({ text: "Answer - 1", correct: false })
      question.answers.create({ text: "Answer - 2", correct: false })
      question.answers.create({ text: "Answer - 3", correct: false })

      expect {
        question.answers.create({ text: "Answer - 4", correct: false })
      }.to raise_error("This question needs at least one correct answer")
    end
  end
end
