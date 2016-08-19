require 'rails_helper'

module Quizzes
  RSpec.describe Answer, type: :model do

    it { should validate_presence_of(:text) }
  end
end
