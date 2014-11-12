class AddTimeLimitToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :time_limit, :long
  end
end
