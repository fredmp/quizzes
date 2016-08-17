# == Schema Information
#
# Table name: quizzes_levels
#
#  id                  :integer          not null, primary key
#  number_of_questions :integer
#  name                :string
#  code                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require_dependency "quizzes/application_record"

module Quizzes
  class Level < ApplicationRecord

    validates :name, :code, :number_of_questions, presence: true

    def self.all_and_nil
      Level.all.to_a + [nil]
    end

  end
end
