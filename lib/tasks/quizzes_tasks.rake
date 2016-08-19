namespace :quizzes do

  desc "Import quizzes from a csv file - usage: rake \"quizzes:import[/home/user/dir/file.csv]\""
  task :import, [:path] => [:environment] do |t, args|
      begin
        require "csv"
        csv = CSV.read(args[:path], headers: true)
        save(extract_questions_from(csv))
      rescue Exception => e
        puts e
      end
  end

  def extract_questions_from(csv)
    questions = []
    csv.each do |row|
      question_field = row['question'].strip
      correct_answer_field = row['correct_answer'].strip
      incorrect = incorrect_answers(row)

      unless question_field.present? && correct_answer_field.present? && total_incorrect_answers == incorrect.size
        raise "Row #{row} \n\nNeeds: 1 question, 1 correct answer and #{total_incorrect_answers} incorrect answers"
      end

      level = Quizzes::Level.where(code: row['level'].strip).first
      question = Quizzes::Question.new(text: question_field, level: level)
      question.answers.build({ text: correct_answer_field, correct: true })
      incorrect.each do |i|
        question.answers.build({ text: i, correct: false })
      end

      questions << question
    end
    questions
  end

  def incorrect_answers(row)
    row.to_a.select do |value|
      value[0] =~ /answer\d/
    end.map do |selected|
      selected[1].strip
    end
  end

  def total_incorrect_answers
    (Rails.configuration.total_answers_by_question rescue 4) - 1
  end

  def save(questions)
    total_saved = 0
    questions.each do |question|
      if question.valid?
        question.save
        print "."
        total_saved = total_saved + 1
      else
        puts "Question: #{question.text} not saved - Error: #{question.errors.full_messages}"
      end
    end
    puts "\n\n#{total_saved} saved."
  end

end
