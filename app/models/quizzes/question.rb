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

    belongs_to :level, optional: true

    has_many :answers, before_add: [
      :ensure_at_least_one_correct_answer,
      :ensure_only_one_correct_answer,
      :check_answers_limit
    ]

    validates :text, presence: true, uniqueness: true

    def self.generate_set (levels, number_of_questions, used_questions = [])
      questions = search(levels, number_of_questions, used_question_ids(used_questions))

      unless all_requested_questions_found?(questions.size, number_of_questions)
        number_of_questions = reviewed_number_of_questions(questions, number_of_questions)
        if(number_of_questions > 0)
          questions += generate_set(Level.all_and_nil, number_of_questions, questions + used_questions)
        end
      end
      questions.sort{|a, b| a.level && b.level ? a.level.code <=> a.level.code : a.level ? -1 : 1 }
    end

    def correct_answer
      self.answers.where(correct: true).first
    end

    private

    def self.search(levels, quantity, used_ids)
      Quizzes::Question.where(level: levels).where.not(id: used_ids).sample(quantity)
    end

    def self.all_requested_questions_found?(found, requested)
      found == requested
    end

    def self.reviewed_number_of_questions(questions, number_of_questions)
      total_questions = Quizzes::Question.count
      (number_of_questions > total_questions ? total_questions : number_of_questions) - questions.size
    end

    def self.used_question_ids used_questions
      if used_questions && used_questions.any?
        return used_questions.map(&:id)
      end
      return [0]
    end

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
      raise "This question have reached the limit of answers" if answer_limit_reached?
    end

    def answers_limit
      Rails.configuration.total_answers_by_question rescue 4
    end

  end
end
