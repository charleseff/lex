class CreateNewStudentPassCode < ActiveRecord::Migration
  def self.up
    # the password 'mobydick' should hash to this value:
    ActiveRecord::Base.connection.insert("replace into key_value_pairs  (id, k, v) values
( 1,  'new_student_passcode', '0cd52dbee387e49fe130c90bd9f00bafef134814' )")
  end

  def self.down
  end
end
