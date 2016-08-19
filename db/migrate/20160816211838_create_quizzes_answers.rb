class CreateQuizzesAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_answers do |t|
      t.string :text
      t.references :question, foreign_key: {to_table: :quizzes_questions, name: "question_id"}
      t.boolean :correct

      t.timestamps
    end
  end
end
