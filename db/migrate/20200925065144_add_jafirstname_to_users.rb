class AddJafirstnameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ja_first_name, :string
  end
end
