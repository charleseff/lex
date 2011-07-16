class CreatePtals < ActiveRecord::Migration
  def self.up
    create_table :ptals do |t|
      t.column :grade_level, :int
    end

    ActiveRecord::Base.connection.insert("replace into ptals (id, grade_level) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7)")
  end

  def self.down
    drop_table :ptals
  end
end
