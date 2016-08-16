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

require 'rails_helper'

module Quizzes
  RSpec.describe User, type: :model do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
