module Quizzes
  class GameFactory

    def initialize(params = {})
      @user = params[:user]
      @level = params[:level]
      @number_of_questions = params[:number_of_questions]
    end

    def generate
      game = Quizzes::Game.new
      game.user = @user
      game.level = @level

      questions = Quizzes::QuestionFactory.new({
        levels: group_of_levels,
        used_questions: used_questions,
        number_of_questions: verified_number_of_questions
      }).generate

      Quizzes::GameQuestionFactory.new({ game: game, questions: questions }).generate

      game
    end

    private

    def group_of_levels
      @level.present? ? [@level] : Quizzes::Level.all_and_nil
    end

    def used_questions
      @user.present? ? @user.questions : []
    end

    def verified_number_of_questions
      @number_of_questions || (@level.present? ? @level.number_of_questions : total_questions_by_game)
    end

    def total_questions_by_game
      Rails.configuration.total_questions_by_game rescue 10
    end

  end
end
