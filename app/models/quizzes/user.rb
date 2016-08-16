# == Schema Information
#
# Table name: quizzes_users
#
#  id         :integer          not null, primary key
#  name       :string
#  points     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_dependency "quizzes/application_record"

module Quizzes
  class User < ApplicationRecord
    has_many :games, dependent: :destroy
    has_many :game_questions, through: :games
    has_many :questions, through: :game_questions
  end
end
