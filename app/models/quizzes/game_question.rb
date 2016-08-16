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
    belongs_to :game
    belongs_to :question

    def self.generate_set game, questions
      game_questions = []
      questions.each do |question|

        seed_to_shuffle_answers = Random.new(question.id + Date.new.day.to_i)
        game_questions << Quizzes::GameQuestion.new(game: game, question: question, seed_to_shuffle_answers: seed_to_shuffle_answers)
      end
      game_questions
    end

    def correct? answer_id
      question.correct_answer.id == answer_id
    end

    def shuffled_answers
      answers = question.answers
      [
        {id: answers[0].id, text: answers[0].text},
        {id: answers[1].id, text: answers[1].text},
        {id: answers[2].id, text: answers[2].text},
        {id: answers[3].id, text: answers[3].text}
      ].shuffle(random: seed_to_shuffle_answers)
    end
  end
end
