class AddDisplayNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :display_name, :string, default: ""
  end
end
