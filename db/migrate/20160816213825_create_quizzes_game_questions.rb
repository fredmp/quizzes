class CreateQuizzesGameQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_game_questions do |t|
      t.references :game, foreign_key: {to_table: :quizzes_games, name: "game_id"}
      t.references :question, foreign_key: {to_table: :quizzes_questions, name: "question_id"}

      t.integer :seed_to_shuffle_answers

      t.timestamps
    end
  end
end
