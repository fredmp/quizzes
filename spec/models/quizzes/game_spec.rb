# == Schema Information
#
# Table name: quizzes_games
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  level_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

module Quizzes
  RSpec.describe Game, type: :model do

    before(:each) do
      create_questions_in_sequence(20)
    end

    it "should create a game for a user" do
      game = Game.generate(create(:level), 20, create(:user))
      expect(game.game_questions.size).to eq(20)
    end

  end
end
