class AddScoreNumberToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :score_number, :integer, :default => 0
  end

  def self.down
    remove_column :products, :score_number
  end
end
