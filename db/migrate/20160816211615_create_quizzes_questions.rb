class CreateQuizzesQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_questions do |t|
      t.string :text
      t.references :level, foreign_key: true

      t.timestamps
    end
  end
end
