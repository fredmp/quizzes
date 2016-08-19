# == Schema Information
#
# Table name: quizzes_game_questions
#
#  id                      :integer          not null, primary key
#  game_id                 :integer
#  question_id             :integer
#  seed_to_shuffle_answers :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require_dependency "quizzes/application_record"

module Quizzes
  class GameQuestion < ApplicationRecord

    belongs_to :game, foreign_key: "game_id", class_name: Quizzes::Game
    belongs_to :question, foreign_key: "question_id", class_name: Quizzes::Question

    validates :game, :question, presence: true

    def correct? answer_id
      question.correct_answer.id == answer_id
    end

    def answers
      [
        {id: question.answers[0].id, text: question.answers[0].text},
        {id: question.answers[1].id, text: question.answers[1].text},
        {id: question.answers[2].id, text: question.answers[2].text},
        {id: question.answers[3].id, text: question.answers[3].text}
      ].shuffle(random: seed_to_shuffle_answers)
    end

  end
end
