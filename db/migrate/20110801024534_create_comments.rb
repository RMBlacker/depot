class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force=>true do |t|
      t.integer :product_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
