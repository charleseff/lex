class KeyValuePair < ActiveRecord::Base
  validates_uniqueness_of   :key, :case_sensitive => false

end
