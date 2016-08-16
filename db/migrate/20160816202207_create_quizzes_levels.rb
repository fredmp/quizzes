class CreateQuizzesLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_levels do |t|
      t.integer :number_of_questions
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
