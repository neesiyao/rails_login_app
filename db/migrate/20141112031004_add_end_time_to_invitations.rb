class AddEndTimeToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :end_time, :string
  end
end
