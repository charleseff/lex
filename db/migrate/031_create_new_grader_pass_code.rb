class CreateNewGraderPassCode < ActiveRecord::Migration
  def self.up
    # the password 'scarletletter' should hash to this value:
    ActiveRecord::Base.connection.insert("replace into key_value_pairs  (id, k, v) values
( 2,  'new_grader_passcode', 'e4fc074cb82a34f518881527a6ebe6cbef39c586' )")
  end

  def self.down
  end
end
