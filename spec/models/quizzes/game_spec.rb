require 'rails_helper'

module Quizzes
  RSpec.describe Game, type: :model do

    it { should validate_presence_of(:user) }

  end
end
