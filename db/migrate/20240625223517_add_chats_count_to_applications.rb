class AddChatsCountToApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :applications, :chats_count, :integer, default: 0, null: false
  end
end
