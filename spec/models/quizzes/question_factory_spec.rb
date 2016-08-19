require 'rails_helper'

module Quizzes
  RSpec.describe QuestionFactory, type: :model do

    before(:each) do
      create_questions_in_sequence(20)
    end

    it "returns the informed number of questions" do
      expect(
        QuestionFactory.new({ levels: Level.all_and_nil, number_of_questions: 2 }).generate.size
      ).to eq(2)
    end

    it "returns existing number of questions when what is informed exceeds the total" do
      expect(
        QuestionFactory.new({ levels: Level.all_and_nil, number_of_questions: 44 }).generate.size
      ).to eq(20)
    end

    it "considers the level" do
      level = create(:level)
      question = create(:question, text: "Question of level #{level.name}", level: level)

      expect(
        QuestionFactory.new({ levels: [level], number_of_questions: 1 }).generate.first.text
      ).to eq("Question of level #{level.name}")
    end

    it "returns unique questions" do
      ids = QuestionFactory.new({ levels: Level.all_and_nil, number_of_questions: 10 }).generate.map(&:id)
      expect(ids.size).to eq(ids.uniq.size)
    end

    it "avoids questions already used" do
      level = create(:level)
      used_question = create(:question, text: "Question of level #{level.name}", level: level)

      questions = QuestionFactory.new({ levels: [level], used_questions: [used_question], number_of_questions: 15 }).generate

      questions.each do |question|
        expect(question).not_to eq(used_question)
      end
    end
  end
end
