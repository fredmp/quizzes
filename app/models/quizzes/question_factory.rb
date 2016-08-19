module Quizzes
  class QuestionFactory

    def initialize(params = {})
      @levels = params[:levels]
      @used_questions = params[:used_questions] || []
      @number_of_questions = params[:number_of_questions]
      unless @levels && @number_of_questions
        raise "It needs an array of levels and a number of questions"
      end
    end

    def generate
      questions = search

      unless all_requested_questions_found?(questions)
        number_of_questions = reviewed_number_of_questions(questions)
        if(number_of_questions > 0)
          questions += Quizzes::QuestionFactory.new({
            levels: Quizzes::Level.all_and_nil,
            used_questions: questions + @used_questions,
            number_of_questions: number_of_questions
          }).generate
        end
      end
      questions.sort{|a, b| a.level && b.level ? a.level.code <=> a.level.code : a.level ? -1 : 1 }
    end

    private

    def search
      Quizzes::Question.where(
        level: @levels
      ).where.not(
        id: question_ids_used
      ).sample(@number_of_questions)
    end

    def all_requested_questions_found?(questions)
      questions.size == @number_of_questions
    end

    def reviewed_number_of_questions(questions)
      total_questions = Quizzes::Question.count
      (@number_of_questions > total_questions ? total_questions : @number_of_questions) - questions.size
    end

    def question_ids_used
      if @used_questions && @used_questions.any?
        return @used_questions.map(&:id)
      end
      return [0]
    end

  end
end
