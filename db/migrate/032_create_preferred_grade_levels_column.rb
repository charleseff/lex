class CreatePreferredGradeLevelsColumn < ActiveRecord::Migration
  def self.up
    # this column will actually be interpreted as a bit array (too bad ActiveRecord doesnt seem to support that...)
    add_column :users, :preferred_grade_levels, :integer

  end

  def self.down
    remove_column :users, :preferred_grade_levels
  end
end
