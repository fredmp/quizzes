class CreateQuizzesGames < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_games do |t|
      t.references :quizzes_user, foreign_key: true
      t.references :quizzes_level, foreign_key: true

      t.timestamps
    end
  end
end
