require 'rails_helper'

module Quizzes
  RSpec.describe User, type: :model do

    it "responds to games" do
      expect(subject).to respond_to(:games)
    end

    it "responds to questions" do
      expect(subject).to respond_to(:game_questions)
    end

    it "responds to game questions" do
      expect(subject).to respond_to(:questions)
    end

  end
end
