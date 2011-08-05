class AddAttrToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :realname, :string,:force => true
    add_column :users, :email, :string,:force => true
    add_column :users, :address, :string  ,:force => true  
    add_column :users, :phone, :string,:force => true
    add_column :users, :authority, :boolean,:force => true,:default=>false
  end

  def self.down
    remove_column :users, :realname
    remove_column :users, :email
    remove_column :users, :address
    remove_column :users, :phone
    remove_column :users, :authority
  end
end
