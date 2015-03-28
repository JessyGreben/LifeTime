class RemoveJidFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :jid, :integer
  end
end
