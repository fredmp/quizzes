module Quizzes
  class GameQuestionFactory

    def initialize(params = {})
      @game = params[:game]
      @questions = params[:questions]
      unless @game && @questions && @questions.any?
        raise "It needs a game and a set of questions"
      end
    end

    def generate
      @questions.each do |question|
        @game.game_questions.build({ game: @game, question: question, seed_to_shuffle_answers: generate_seed_for(question) })
      end
      @game.game_questions
    end

    private

    def generate_seed_for(question)
      (Random.new(question.id + DateTime.current.day.to_i).rand * 100).to_i
    end
  end
end
