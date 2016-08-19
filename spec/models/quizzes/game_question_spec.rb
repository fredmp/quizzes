require 'rails_helper'

module Quizzes
  RSpec.describe GameQuestion, type: :model do

    it { should validate_presence_of(:game) }

    before(:each) do
      create_questions_in_sequence(20)
      @game_questions = GameQuestionFactory.new({ game: create(:game), questions: Question.all }).generate
    end

    it "does have only one correct answer among all choices" do
      number_of_right_answers = 0
      game_question = @game_questions.first
      game_question.question.answers.each do |answer|
        number_of_right_answers = number_of_right_answers + 1 if answer.correct?
      end
      expect(number_of_right_answers).to eq(1)
    end

    it "is able to identify the correct answer" do
      expect(
        @game_questions.first.correct?(@game_questions.first.question.correct_answer.id)
      ).to be true
    end

  end
end
