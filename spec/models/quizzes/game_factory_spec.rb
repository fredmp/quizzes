require 'rails_helper'

module Quizzes
  RSpec.describe GameFactory, type: :model do

    it "creates a game for a user" do
      create_questions_in_sequence(20)
      game = GameFactory.new({ user: create(:user), level: create(:level), number_of_questions: 20 }).generate
      expect(game.game_questions.size).to eq(20)
    end

  end
end
