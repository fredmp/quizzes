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

    validates :game, :question, presence: true

    def self.generate_set(game, questions)
      questions.map do |question|
        Quizzes::GameQuestion.new(
          game: game, question: question, seed_to_shuffle_answers: generate_seed_for(question)
        )
      end
    end

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

    private

    def self.generate_seed_for(question)
      Random.new(question.id + Date.new.day.to_i)
    end
  end
end
