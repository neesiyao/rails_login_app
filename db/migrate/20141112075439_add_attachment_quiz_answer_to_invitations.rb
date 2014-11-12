class AddAttachmentQuizAnswerToInvitations < ActiveRecord::Migration
  def self.up
    change_table :invitations do |t|
      t.attachment :quiz_answer
    end
  end

  def self.down
    remove_attachment :invitations, :quiz_answer
  end
end
