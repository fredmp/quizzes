class CreateQuizzesGames < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_games do |t|
      t.references :user, foreign_key: {to_table: :quizzes_users, name: "user_id"}
      t.references :level, foreign_key: {to_table: :quizzes_levels, name: "level_id"}

      t.timestamps
    end
  end
end
