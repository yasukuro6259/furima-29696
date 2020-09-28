class AddFamilynameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :family_name, :string
  end
end
