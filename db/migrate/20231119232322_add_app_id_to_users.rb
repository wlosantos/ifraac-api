class AddAppIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :app_id, :integer, null: false, foreign_key: { to_table: :apps }
  end
end
