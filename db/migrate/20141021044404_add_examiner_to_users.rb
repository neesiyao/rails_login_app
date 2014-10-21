class AddExaminerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :examiner, :boolean
  end
end
