class CreateQuizzesAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_answers do |t|
      t.string :text
      t.references :quizzes_question, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
