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
    has_many :answers

    def self.generate_set level = nil, number_of_questions = nil, already_used_questions = []
      number_of_questions = current_number_of_questions(number_of_questions, level)
      already_used_question_ids = already_used_question_ids(already_used_questions)
      levels = level.present? ? [level] : Level.all + [nil]
      questions = Quizzes::Question.where(level: levels).where.not(id: already_used_question_ids).sample(number_of_questions)
      if(questions.size < number_of_questions)
        number_of_existing_questions = Quizzes::Question.count
        number_of_questions = number_of_existing_questions if number_of_questions > number_of_existing_questions
        number_of_questions = number_of_questions - questions.size
        if(number_of_questions > 0)
          questions += generate_set(nil, number_of_questions, questions + already_used_questions)
        end
      end
      questions.sort{|a, b| a.level && b.level ? a.level.code <=> a.level.code : a.level ? -1 : 1 }
    end

    def correct_answer
      for answer in answers do
        return answer if answer.correct?
      end
    end

    private

    def self.current_number_of_questions original_number_of_questions, level
      if original_number_of_questions.nil?
        if level
          return level.number_of_questions
        else
          return 10
        end
      end
      return original_number_of_questions
    end

    def self.already_used_question_ids already_used_questions
      if already_used_questions && already_used_questions.any?
        return already_used_questions.map(&:id)
      end
      return [0]
    end

  end
end
