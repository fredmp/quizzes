# == Schema Information
#
# Table name: quizzes_answers
#
#  id          :integer          not null, primary key
#  text        :string
#  question_id :integer
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require_dependency "quizzes/application_record"

module Quizzes
  class Answer < ApplicationRecord

    belongs_to :question
    validates :text, presence: true

  end
end
