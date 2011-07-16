class CreateKeyValuePairs < ActiveRecord::Migration
  def self.up
    create_table :key_value_pairs do |t|
      t.column :k, :string
      t.column :v, :string
    end
    # how to not have id's?
  end

  def self.down
    drop_table :key_value_pairs
  end
end
