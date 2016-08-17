require 'rails_helper'

module Quizzes
  RSpec.describe User, type: :model do

    it "should respond to games" do
      expect(subject).to respond_to(:games)
    end

    it "should respond to questions" do
      expect(subject).to respond_to(:game_questions)
    end

    it "should respond to game questions" do
      expect(subject).to respond_to(:questions)
    end

  end
end
