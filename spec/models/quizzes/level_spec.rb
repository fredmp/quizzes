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

require 'rails_helper'

module Quizzes
  RSpec.describe Level, type: :model do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
