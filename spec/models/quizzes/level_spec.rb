require 'rails_helper'

module Quizzes
  RSpec.describe Level, type: :model do

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:number_of_questions) }

    context "#all_and_nil" do
      it "returns an array with all levels and nil" do
        expect(Level.all_and_nil).to match_array(Level.all.to_a + [nil])
      end
    end

  end
end
