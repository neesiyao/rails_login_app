class AddSenderNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :sender_name, :string
  end
end
