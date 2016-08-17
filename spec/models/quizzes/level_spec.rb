require 'rails_helper'

module Quizzes
  RSpec.describe Level, type: :model do

    context "#all_and_nil" do
      it "should return an array with all levels and nil" do
        expect(Level.all_and_nil).to match_array(Level.all.to_a + [nil])
      end
    end

  end
end
