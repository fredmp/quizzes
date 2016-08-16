class CreateQuizzesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_users do |t|
      t.string :name
      t.string :points

      t.timestamps
    end
  end
end
