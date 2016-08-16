# == Schema Information
#
# Table name: quizzes_game_questions
#
#  id                      :integer          not null, primary key
#  game_id                 :integer
#  question_id             :integer
#  seed_to_shuffle_answers :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'rails_helper'

module Quizzes
  RSpec.describe GameQuestion, type: :model do

    before(:each) do
      create_questions_in_sequence(20)
      @game = create(:game)
      @questions = Question.all
      @game_questions = GameQuestion.generate_set(@game, @questions)
    end

    it "should build a set of questions" do
      expect(@game_questions.size).to eq(@questions.size)
      one_game_question = @game_questions.first
      expect(one_game_question.game).to eq(@game)
      expect(one_game_question.question.answers.size).to eq(4)
    end

    it "should have one correct question answer" do
      number_of_right_answers = 0
      one_game_question = @game_questions.first
      one_game_question.question.answers.each do |answer|
        number_of_right_answers = number_of_right_answers + 1 if answer.correct?
      end
      expect(number_of_right_answers).to eq(1)
    end

    it "should have one correct game question answer" do
      one_game_question = @game_questions.first

      expect(one_game_question.correct?(one_game_question.question.correct_answer.id)).to be true
    end

  end
end
