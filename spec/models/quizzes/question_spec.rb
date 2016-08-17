# == Schema Information
#
# Table name: quizzes_questions
#
#  id         :integer          not null, primary key
#  text       :string
#  level_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

module Quizzes
  RSpec.describe Question, type: :model do

    it "should allow exactly one correct answer" do
      question = FactoryGirl.create(:question)

      question.answers.create({ text: "Answer - 1", correct: false })
      question.answers.create({ text: "Answer - 2", correct: false })
      question.answers.create({ text: "Answer - 3", correct: true })

      expect {
        question.answers.create({ text: "Answer - 4", correct: true })
      }.to raise_error("A question can have only one correct answer")

    end

    context "#generate_set" do

      before(:each) do
        create_questions_in_sequence(20)
      end

      it "should generate a basic set of questions with a default quantity" do
        questions = Question.generate_set
        expect(questions.size).to eq(10)
      end

      it "should generate the informed number of questions" do
        questions = Question.generate_set(nil, 2)
        expect(questions.size).to eq(2)
      end

      it "should generate the existing number of questions when what is informed exceeds" do
        questions = Question.generate_set(nil, 44)
        expect(questions.size).to eq(20)
      end

      it "should generate questions considering the level" do
        level = create(:level)
        question = create(:question, text: "Question of level #{level.name}", level: level)

        questions = Question.generate_set(level, nil)

        expect(questions.size).to eq(level.number_of_questions)
        expect(questions.first.text).to eq("Question of level #{level.name}")
        expect(questions.last.text).to match(/Question text/)
      end

      it "should generate unique questions" do
        ids = Question.generate_set(@level, nil, nil).map(&:id)
        expect(ids.size).to eq(ids.uniq.size)
      end

      it "should generate questions ignoring the used ones" do
        level = create(:level)
        level = create(:level)
        used_question = create(:question, text: "Question of level #{level.name}", level: level)

        questions = Question.generate_set(level, nil, [used_question])

        questions.each do |question|
          expect(question).not_to eq(used_question)
        end
        expect(questions.size).to eq(level.number_of_questions)
      end
    end


  end
end
