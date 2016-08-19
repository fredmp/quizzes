require 'rails_helper'

module Quizzes
  RSpec.describe Game, type: :model do

    it { should validate_presence_of(:user) }

    it "creates a game for a user" do
      create_questions_in_sequence(20)
      game = Game.generate({ user: create(:user), level: create(:level), number_of_questions: 20 })
      expect(game.game_questions.size).to eq(20)
    end

  end
end
