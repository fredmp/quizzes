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

require_dependency "quizzes/application_record"

module Quizzes
  class Game < ApplicationRecord

    belongs_to :user
    belongs_to :level
    has_many :game_questions, dependent: :destroy
    has_many :questions, through: :game_questions

    validates :user, presence: true

    def self.generate(params = {})
      game = Quizzes::Game.new
      game.user = params[:user]
      game.level = params[:level] || Level.first

      questions = Question.generate_set(
        levels_from(params[:level]),
        number_of_questions(params[:number_of_questions]),
        used_questions_from(params[:user])
      )

      game.game_questions = Quizzes::GameQuestion.generate_set(game, questions)
      game
    end

    def self.levels_from(level)
      level.present? ? [level] : Level.all_and_nil
    end

    def self.used_questions_from(user)
      user.present? ? user.questions : []
    end

    def self.number_of_questions(number_of_questions)
      number_of_questions || (level.present? ? level.number_of_questions : 10)
    end

  end
end
