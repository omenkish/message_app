class ChangeResetSentOn < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :reset_sent_on, :reset_sent_at
  end
end
