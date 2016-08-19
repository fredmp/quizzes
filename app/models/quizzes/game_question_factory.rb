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
      @questions.map do |question|
        Quizzes::GameQuestion.new(
          game: @game, question: question, seed_to_shuffle_answers: generate_seed_for(question)
        )
      end
    end

    private

    def generate_seed_for(question)
      Random.new(question.id + Date.new.day.to_i)
    end
  end
end
