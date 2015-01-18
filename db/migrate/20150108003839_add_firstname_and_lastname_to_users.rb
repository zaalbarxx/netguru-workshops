class AddFirstnameAndLastnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, :after => :encrypted_password
    add_column :users, :lastname, :string, :after => :firstname
  end
end
