class CreateQuizzesGameQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_game_questions do |t|
      t.references :game, foreign_key: true
      t.references :question, foreign_key: true
      t.integer :seed_to_shuffle_answers

      t.timestamps
    end
  end
end
