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

require 'rails_helper'

module Quizzes
  RSpec.describe Answer, type: :model do
  end
end
