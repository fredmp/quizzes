require 'rails_helper'

module Quizzes
  RSpec.describe GameQuestionFactory, type: :model do

    before(:each) do
      create_questions_in_sequence(20)
      @game = create(:game)
      @questions = Question.limit(10)
    end

    it "needs a game and a set of questions to build a set of game questions" do
      expect {
        GameQuestionFactory.new({ game: @game })
      }.to raise_error("It needs a game and a set of questions")

      expect {
        GameQuestionFactory.new({ questions: @questions })
      }.to raise_error("It needs a game and a set of questions")
    end

    it "builds a set of questions" do
      game_questions = GameQuestionFactory.new({ game: @game, questions: @questions }).generate

      expect(game_questions.size).to eq(10)
      game_question = game_questions.first
      expect(game_question.game).to eq(@game)
    end

  end
end
