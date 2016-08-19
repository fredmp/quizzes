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

    context "#generate_set" do

      before(:each) do
        create_questions_in_sequence(20)
      end

      it "returns the informed number of questions" do
        questions = Question.generate_set(Level.all_and_nil, 2)
        expect(questions.size).to eq(2)
      end

      it "returns existing number of questions when what is informed exceeds the total" do
        questions = Question.generate_set(Level.all_and_nil, 44)
        expect(questions.size).to eq(20)
      end

      it "considers the level" do
        level = create(:level)
        question = create(:question, text: "Question of level #{level.name}", level: level)

        questions = Question.generate_set([level], 1)

        expect(questions.first.text).to eq("Question of level #{level.name}")
      end

      it "returns unique questions" do
        ids = Question.generate_set(Level.all_and_nil, 10).map(&:id)
        expect(ids.size).to eq(ids.uniq.size)
      end

      it "avoids questions already used" do
        level = create(:level)
        used_question = create(:question, text: "Question of level #{level.name}", level: level)

        questions = Question.generate_set([level], 15, [used_question])

        questions.each do |question|
          expect(question).not_to eq(used_question)
        end
      end
    end
  end

end
