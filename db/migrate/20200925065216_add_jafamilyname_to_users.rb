class AddJafamilynameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ja_family_name, :string
  end
end
