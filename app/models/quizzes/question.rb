# == Schema Information
#
# Table name: quizzes_questions
#
#  id         :integer          not null, primary key
#  text       :string
#  level_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_dependency "quizzes/application_record"

module Quizzes
  class Question < ApplicationRecord

    belongs_to :level, optional: true, foreign_key: "level_id", class_name: Quizzes::Level

    has_many :answers, dependent: :destroy, before_add: [
      :ensure_at_least_one_correct_answer,
      :ensure_only_one_correct_answer,
      :check_answers_limit
    ]

    validates :text, presence: true, uniqueness: true

    def correct_answer
      self.answers.where(correct: true).first
    end

    private

    def ensure_at_least_one_correct_answer(answer)
      unless answer.correct? || answers.select {|a| a.correct?}.any? || correct_answer.present? || free_answer_slots > 1
        raise "This question needs at least one correct answer"
      end
    end

    def ensure_only_one_correct_answer(answer)
      if answer.correct? && correct_answer.present?
        raise "A question can have only one correct answer"
      end
    end

    def free_answer_slots
      answers_limit - self.answers.size
    end

    def answer_limit_reached?
      free_answer_slots < 1
    end

    def check_answers_limit(answer)
      raise "This question has reached the maximum number of allowed answers" if answer_limit_reached?
    end

    def answers_limit
      Rails.configuration.total_answers_by_question rescue 4
    end

  end
end
